class ProductInventoriesController < ApplicationController
  # GET /product_inventories
  # GET /product_inventories.xml
  def index
    if params[:search] 
      params[:search] = search = ( params[:search].strip != '' ?  params[:search].strip : nil )      
    end  
    
    if params[:list]
        params[:list] = list = ( params[:list].strip != '' ?  params[:list].strip : nil )
    end      
      
    @product_inventories = current_user.product_inventories.search(search)
    
    @title = "Controle de Estoque"
    
    case list
    when 'out_of_stock'
      @title << ' - Em falta'  
      @product_inventories = @product_inventories.out_of_stock  
    else
      @title << ' - Todos'
    end 
    
    # Return
    @product_inventories = @product_inventories.paginate(:per_page => 20, :page => params[:page])     
  end
   
  def show
    @title = "Produto do Estoque"
    @product_inventory = current_user.product_inventories.find(params[:id])   
  end

  def new
    @title = "Adicionar novo Produto ao Estoque"
    
    @product_inventory = current_user.product_inventories.new
    
    if params[:product_id]
      @product_inventory = current_user.product_inventories.find_by_product_id(params[:product_id])      
      render :edit if @product_inventory    
      
      @product = Product.find(params[:product_id])      
      @product_inventory = @product.product_inventories.new(:user => current_user)
    end       
  end


  def edit
    @title = "Editar Produto do Estoque"
    @product_inventory = current_user.product_inventories.find(params[:id])
  end

  def create    
    @product_inventory = current_user.product_inventories.new(params[:product_inventory])
    
    if @product_inventory.save
      redirect_to @product_inventory
    else
      render :new
    end
  end

  def update
    @product_inventory = current_user.product_inventories.find(params[:id])
    
    if @product_inventory.update_attributes(params[:product_inventory])
      flash[:notice] = "Produto em estoque atualizado."
      redirect_to @product_inventory
    else
      render :edit
    end
  end

  def destroy
    @product_inventory = current_user.product_inventories.find(params[:id])
    @product_inventory.destroy
  end
end
