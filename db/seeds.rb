puts 'Setting up default user login'

user = User.create! :name => 'First User', :email => 'user@example.com', 
                    :password => 'please', :password_confirmation => 'please'
                    
puts 'New user created: ' << user.name
