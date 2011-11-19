class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :allow_only_super_user, :except => [:index, :show]
  
  def index   
    if params[:search] 
      params[:search] = search = ( params[:search].strip != '' ?  params[:search].strip : nil )      
    end       
    
    @products = Product.search(search).not_deleted.paginate(:per_page => 20, :page => params[:page])    
    
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @products }
      format.json { render :json => @products }
    end   
    
  end
  
  def show    
    @product = Product.find(params[:id])
    # TODO: Show order items for Products
    # @order_items = OrderItem.all
    @order_items = []
  end
  
  def new
    @product = Product.new       
  end
  
  def create 
    @product = Product.new(params[:product])
    if @product.save
      redirect_to products_url
    else
      render :new
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product updated successfully."
      redirect_to @product      
    else
      render :edit
    end
  end
  
  def destroy
    @product = products.find(params[:id])
    @product.deleted_at = Time.now()
    
    if @product.save
      flash[:notice] = t("notice_messages.product_deleted")
      redirect_to products_url
    else
      flash[:notice] = t("notice_messages.product_not_deleted")
    end    
  end
end
