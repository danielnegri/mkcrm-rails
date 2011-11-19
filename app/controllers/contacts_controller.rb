class ContactsController < ApplicationController
  before_filter :authenticate_user!
  
  def index           
    if params[:search] 
      params[:search] = search = ( params[:search].strip != '' ?  params[:search].strip : nil )      
    end  
    
    if params[:list]
        params[:list] = list = ( params[:list].strip != '' ?  params[:list].strip : nil )
    end      
      
    @contacts = current_user.contacts.search(search)
    
    @title = "Lista de Contatos"
    
    case list
    when 'all'
      @contacts = @contacts.order_by_name.all
      @title << ' - Todos'
    when 'last'
      @contacts = @contacts.not_deleted.order("id desc")
      @title << ' - Últimos'
    when 'best'
      @contacts = @contacts.not_deleted.order("score desc")
      @title << ' - Melhores'
    else
      @contacts = @contacts.not_deleted.order_by_name
      @title << ' - Ativos'
    end 
    
    # Return
    @contacts = @contacts.paginate(:per_page => 20, :page => params[:page])    
  end
  
  def show        
    @contact = current_user.contacts.find(params[:id])
    @title = "Contato - #{@contact.name}" 
    
    # Preview some calls
    if params[:contact_calls] && params[:contact_calls] == "all"
      @contact_calls = @contact.contact_calls.order("called_at desc").limit(100)
    else
      @contact_calls = @contact.contact_calls.order("called_at desc").limit(3)    
    end
    
    
    # Preview some orders
    if params[:orders] && params[:orders] == "all"
      # @orders = @contact.orders.order("ordered_at desc").limit(100)
    else
      # @orders = @contact.orders.order("ordered_at desc").limit(3)    
    end    
    @orders = []
  end
  
  def new
    @title = "Adicionar novo Contato"
    @contact = current_user.contacts.new
    @contact_call = @contact.contact_calls.new
  end
  
  def create 
    @contact = current_user.contacts.new(params[:contact])
    if @contact.save
      redirect_to @contact
    else
      render :new
    end
  end
  
  def edit    
    @contact = current_user.contacts.find(params[:id])
    @title = "Editar Contato - #{@contact.name}" 
  end
  
  def update
    @contact = current_user.contacts.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:notice] = "Contato atualizado."
      redirect_to @contact
    else
      render :edit
    end
  end
  
  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.deleted_at = Time.now()
    
    if @contact.save
      flash[:notice] = t("notice_messages.contact.deleted")
      redirect_to contacts_url
    else
      flash[:notice] = t("notice_messages.contact,not_deleted")
    end    
  end  
  
end
