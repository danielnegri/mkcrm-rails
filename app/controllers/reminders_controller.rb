class RemindersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if params[:search] 
      params[:search] = search = ( params[:search].strip != '' ?  params[:search].strip : nil )      
    end
    
    if params[:status] 
      params[:status] = status = ( params[:status].strip != '' ?  params[:status].strip : nil )      
    end
    
    @yesterday = Time.zone.now - 1.day
    @scheduled_at = parse_date @yesterday.strftime(t("date.formats.default"))
    if params[:scheduled_at]      
      @scheduled_at = parse_date params[:scheduled_at]      
    end   

    @title = "Lista de Lembretes"         
    
    if status == 'due'
      @reminders = current_user.reminders.all.paginate(:per_page => 20, :page => params[:page]) 
      @overdue_reminders = current_user.reminders.overdue.paginate(:per_page => 20, :page => params[:page]) 
    else 
      @reminders = current_user.reminders.search(search).scheduled_at(@scheduled_at).paginate(:per_page => 20, :page => params[:page])       
      @overdue_reminders = current_user.reminders.overdue.paginate(:per_page => 5, :page => params[:page]) 
    end   
  end
  
  def show        
    # @reminder = current_user.reminders.find(params[:id])
    # @title = "Lembrete"   
    redirect_to reminders_path  
  end
  
  def new
    @title = "Adicionar novo Lembrete"
    @reminder = current_user.reminders.new
    @reminder.scheduled_at ||= Time.zone.now + 1.hour
  end
  
  def create 
    @reminder = current_user.reminders.new(params[:reminder])
    if @reminder.save
      redirect_to @reminder
    else
      render :new
    end
  end
  
  def edit    
    @reminder = current_user.reminders.find(params[:id])
    @title = "Editar Lembrete" 
  end
  
  def update
    @reminder = current_user.reminders.find(params[:id])
    
    if @reminder.update_attributes(params[:reminder])
      flash[:notice] = "Lembrete atualizado."
      redirect_to @reminder
    else
      render :edit
    end
  end
  
  def destroy
    @reminder = current_user.reminders.find(params[:id])
        
    if @reminder.destroy
      flash[:notice] = 'Lembrete removido'
      redirect_to reminders_url
    else
      flash[:notice] = 'Não foi possível remover o lembrete.'
    end    
  end 
  
  def confirm
    @reminder = current_user.reminders.find(params[:id])
    @reminder.confirmed = true
        
    if @reminder.save
      flash[:notice] = 'Lembrete confirmado'
      redirect_to reminders_url
    else
      flash[:notice] = 'Não foi possível confirmar o lembrete.'
    end 
  end
  
end
