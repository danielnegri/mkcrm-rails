# encoding: utf-8

class ContactCallsController < ApplicationController
  before_filter :authenticate_user!
  
  def index  
    @title = "Lista de Ligações"
         
    if params[:search]
      params[:search] = search = ( params[:search].strip != '' ?  params[:search].strip : nil )      
    end
    
    @yesterday = Time.zone.now - 1.day
    @called_at = parse_date @yesterday.strftime(t("date.formats.default"))
    if params[:called_at]      
      @called_at = parse_date params[:called_at]      
    end
      
    @contact_calls = current_user.contact_calls.search(search).called_at(@called_at).paginate(:per_page => 20, :page => params[:page]) 
  end
  
  def show         
    if params[:contact_id]
      @contact_call = current_contact.contact_calls.create(params[:contact_call])
    end
            
    @contact_call ||= current_user.contact_calls.find(params[:id])      
    @title = "Editar Ligação - #{@contact_call.contact.name}"
    render :edit   
  end
  
  def new 
    @contact = current_contact
    @contact_call = @contact.contact_calls.new
    @contact_call.user = current_user
  end
  
  def create         
    @contact_call = current_contact.contact_calls.new(params[:contact_call])
    @contact_call.user = current_user # BUG?
    
    if @contact_call.save
      redirect_to contact_path(@contact_call.contact)
    else
      render :new
    end
  end  
  
  def edit
    if params[:contact_id]
      @contact_call = current_contact.contact_calls.create(params[:contact_call])
    end
            
    @contact_call ||= current_user.contact_calls.find(params[:id])      
    @title = "Editar Ligação - #{@contact_call.contact.name}"
  end
  
  def update
    if params[:contact_id]
      @contact_call = current_contact.contact_calls.create(params[:contact_call])
    end     
         
    @contact_call ||= current_user.contact_calls.find(params[:id])
        
    if @contact_call.update_attributes(params[:contact_call])
      flash[:notice] = "Ligação atualizada."
      redirect_to contact_path(@contact_call.contact)
    else
      render :edit
    end
  end  
  
private
  def current_contact
    @contact = current_user.contacts.find(params[:contact_id])
  end

end
