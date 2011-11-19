class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  # TODO - Corrigir constantes, refatorar classe
  def set_locale
    if user_signed_in?
      # I18n.locale = current_user.profile ? current_user.profile.locale : user_agent_locale       
      I18n.locale = 'pt-BR'       
      Time.zone = current_user.profile ? current_user.profile.time_zone : 'Brasilia'    
    else
      I18n.locale = 'pt-BR'
      Time.zone = 'Brasilia'      
    end    
  end
  
  LOCALES_REGEX = /\b(#{ I18n.available_locales.join('|') })\b/
  
  def user_agent_locale
    unless RAILS_ENV == 'test'
      request.headers['HTTP_ACCEPT_LANGUAGE'].to_s =~ LOCALES_REGEX && $&
    end
  end
  
  def parse_date(date)
    Date.strptime date.gsub(/[{}\s]/, "").gsub(",", "."), t("date.formats.default")
  end
  
  def current_profile 
    if defined? @profile && @profile.id != current_user.profile.id
      @profile
    else
      current_user.profile
    end
  end
  
  def allow_only_super_user 
    return render_error unless current_user.super_user
  end

private
  def render_error
    # head :bad_request
    # raise ActionController::RoutingError.new('forbidden')    
    render :text => "Usuário não autorizado!", :status => 403 
  end
  
end
