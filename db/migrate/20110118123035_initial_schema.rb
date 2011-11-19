class InitialSchema < ActiveRecord::Migration
  def self.up   
    # Contacts
    create_table :contacts do |t|
      t.references :user, :null => false   
      t.integer :friend_id
      t.string :name, :null => false
      t.string :email
      t.string :twitter
      t.string :social_network_url
      t.integer :score, :default => 0
      t.date :date_of_birth
      t.string :hostess
      t.text :address
      t.decimal :latitude, :precision => 10, :scale => 6, :default => -15.79171
      t.decimal :longitude, :precision => 10, :scale => 6, :default => -47.88935    
      t.string :telephone
      t.string :mobile_phone            
      t.text :notes
      t.datetime :deleted_at
      t.integer :last_order_id
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.timestamps
    end    
    
    add_index :contacts, :user_id
    add_index :contacts, :name
    add_index :contacts, :email
    add_index :contacts, :date_of_birth
    add_index :contacts, :telephone
    add_index :contacts, :mobile_phone 
    
    #Contact Details
    create_table :contact_details do |t|
      t.references :contact, :null => false
      t.string :facial_tone_base
      t.string :skin_type, :default => 'normal'
      t.string :skin_tone, :default => 'ivory'
      t.boolean :has_interest_aging_and_cellulite, :default => false
      t.boolean :has_interest_appearance_and_staining, :default => false
      t.boolean :has_interest_aging_and_expression_line, :default => false
      t.boolean :has_interest_fine_wrinkle, :default => false    
      t.boolean :has_interest_become_a_member, :default => false  
      t.timestamps
    end
        
    # Contact Calls
    create_table :contact_calls do |t|
      t.references :user, :null => false   
      t.references :contact, :null => false
      t.datetime :called_at, :null => false, :default => Time.zone.now
      t.integer :duraction, :default => 1 # minute
      t.string :topic
      t.text :description
      t.string :evaluation, :default => 'good'
      t.timestamps
    end
        
    add_index :contact_calls, :contact_id
    add_index :contact_calls, :called_at
    add_index :contact_calls, :topic
    add_index :contact_calls, :evaluation
    
    # Events
    create_table :events do |t|
      t.references :user, :null => false
      t.references :reminder
      t.string :title
      t.datetime :start_at, :null => false
      t.datetime :end_at, :null => false      
      t.string :location
      t.text :description        
      t.string :show_as, :default => 'busy'
      t.string :privacy, :default => 'public'  
      t.string :evaluation, :default => 'good'
      t.datetime :confirmed_at
      t.datetime :canceled_at    
      t.datetime :deleted_at   
      t.timestamps
    end
    
    add_index :events, :user_id               
             
    # Profiles
    create_table :profiles do |t|
      t.references :user, :null => false
      t.string :name
      t.string :code # mk personal code
      t.string :position # mk position
      t.string :location 
      t.string :area # mk area      
      t.string :hometown
      t.text :biography
      t.string :telephone
      t.string :mobile_phone
      t.date :date_of_birth
      t.string :web      
      t.boolean :welcome, :default => true
      t.string :time_zone, :default => 'Brasilia' # "Eastern Time (US & Canada)"
      t.string :language, :default => 'pt-BR' # "en"
      t.string :first_day_of_week, :default => "sunday"
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at      
      t.timestamps
    end
    
    add_index :profiles, :user_id, :unique => true
    add_index :profiles, :name
    add_index :profiles, :location    
    add_index :profiles, :position        
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't roll back from a major release."
  end
end
