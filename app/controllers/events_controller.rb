class EventsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if params[:search] 
      params[:search] = search = ( params[:search].strip != '' ?  params[:search].strip : nil )      
    end
    
    @yesterday = Time.zone.now - 1.day
    @start_at = parse_date @yesterday.strftime(t("date.formats.default"))
    if params[:start_at]      
      @start_at = parse_date params[:start_at]      
    end
    
    @title = "Lista de Eventos"  
    @events = current_user.events.search(search).started_at(@start_at).not_deleted.paginate(:per_page => 20, :page => params[:page]) 
  end

  def show
    # @event = current_user.events.find(params[:id])
    redirect_to events_path
  end

  def new
    @title = "Adicionar novo Evento"  
    @event = current_user.events.new
    @event.start_at ||= Time.zone.now
    @event.end_at ||= Time.zone.now + 1.hour
  end

  def edit
    @title = "Editar Evento"  
    @event = current_user.events.find(params[:id])
  end

  def create
    @event = current_user.events.new(params[:event])

    if @event.save
      redirect_to(@event)
    else
      render :new        
    end
  end
  
  def update
    @event = current_user.events.find(params[:id])
    @event.start_at ||= Time.zone.now
    @event.end_at ||= Time.zone.now + 1.hour

    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.deleted_at = Time.zone.now

    if @event.save
      flash[:notice] = 'Evento atualizado.'
      redirect_to(events_url)
    else
      flash[:notice] = 'Erro.'
    end
  end
  
  def confirm
    @event = current_user.events.find(params[:id])
    @event.confirmed_at = Time.zone.now
    
    if @event.save
      flash[:notice] = 'Evento confirmado.'
      redirect_to(events_url)
    else
      flash[:notice] = 'Erro.'
    end
  end
  
  def cancel
    @event = current_user.events.find(params[:id])
    @event.canceled_at = Time.zone.now
    
    if @event.save
      flash[:notice] = 'Evento cancelado.'
      redirect_to(events_url)
    else
      flash[:notice] = 'Erro.'
    end
  end
    
end
