# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
User.new({ :email => 'administrator@yourdomain.com.br', :password => 'administrador', :password_confirmation => 'administrador', 
  :confirmation_sent_at => Time.zone.now }).save!
user.confirmed_at = Time.zone.now
user.save! 
admin = User.find_by_email('administrador@yourdomain.com.br')
admin.profile = Profile.new
admin.profile.name = 'Administrador CRM'
admin.profile.language = 'pt-BR'
admin.profile.save!