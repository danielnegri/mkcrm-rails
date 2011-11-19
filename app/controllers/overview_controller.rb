class OverviewController < ApplicationController
  before_filter :authenticate_user!
  
  def index   
    @birthdays = current_birthdays.paginate(:per_page => 20, :page => params[:page])  
    @events = current_events    
    
     @title = "Visão Geral - Lista de eventos e aniversariantes" 
  end
  
  
private
  def current_reminders
    now = Time.zone.now
    today = Date.new(now.year, now.month, now.day)
    reminders = current_user.reminders.where("scheduled_at >= :today or confirmed = :confirmed", :today => today, :confirmed => false)
  end 
  
  def current_events
    now = Time.zone.now
    today = Date.new(now.year, now.month, now.day)
    tomorrow = today + 7.day
    events = current_user.events.where("start_at between :today and :tomorrow", :today => today, :tomorrow => tomorrow)
  end
  
  def current_birthdays
    now = Time.zone.now
    today = Date.new(1, now.month, 1)
    tomorrow = today + 31.day
    birthdays = current_user.contacts.where("date_of_birth between :today and :tomorrow and date_of_birth is not null", :today => today, :tomorrow => tomorrow).order(:date_of_birth).order(:name)
    
  end
end
