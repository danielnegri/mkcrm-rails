class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :allow_only_super_user
  
  def index
    if params[:search]
      params[:search] = search = ( params[:search].strip != '' ?  params[:search].strip : nil )      
    end
    
    @reference = Time.zone.now - 1.month
    @ordered_at = parse_date @reference.strftime(t("date.formats.default"))
    if params[:ordered_at]      
      @ordered_at = parse_date params[:ordered_at]      
    end
      
    @orders = current_user.orders.search(search).ordered_at(@reference).paginate(:per_page => 20, :page => params[:page])      
  end
  
  def show
    @order = current_user.orders.find(:params[:id])
  end
  
  def new
    @order = current_user.orders.new
    
    search_product
    
    if params[:contact_id]
      @contact = current_user.contacts.find(params[:contact_id])      
      @order.contact ||= @contact
    end   
    
    add_product(@order)   
    
    @order.order_type = 'in' if params[:type] && params[:type] == 'in'
  
    logger.info "Param: Type = #{params[:type]}"
    logger.info "New order: Type = #{@order.order_type}"
    
    @title = 'Adicionar Pedido de Compra' if @order.order_type == 'in'
    @title ||= 'Adicionar Pedido de Venda'    
  end
  
  def create
    @order = current_user.orders.new(params[:order])
    if @order.save
      redirect_to @order
    else
      render :new
    end    
  end
  
  def edit
    @order = current_user.orders.find(:params[:id])
  end
  
  def update
    @order = current_user.orders.find(:params[:id])
    if @order.update_attributes(params[:order])
      flash[:notice] = "Order updated successfully."
      redirect_to order_url
    else
      render :edit
    end
  end
  
  def destroy
    @order = current_user.orders.find(params[:id])
    @order.deleted_at = Time.now()
    
    if @order.save
      flash[:notice] = t("notice_messages.order_deleted")
      redirect_to orders_url
    else
      flash[:notice] = t("notice_messages.order_not_deleted")
    end
  end
  
  
private    
  def search_product   
    if params[:search] 
      params[:search] = search = ( params[:search].strip != '' ?  params[:search].strip : nil )      
    end       
    
    @products = Product.search(search).not_deleted.paginate(:per_page => 3, :page => params[:page])           
  end 
     
  def add_product(order)
    if params[:product_id]
      product = Product.find(params[:product_id])
      item = OrderItem.new(:product_id => product.id, :order_id => order.id)
      order.order_items << item         
    end
  end 
end
