## Migration Draft


# Contact Nominess
create_table :contact_nominees do |t|
  t.references :user, :null => false   
  t.references :contact, :null => false
  t.string :name, :null => false
  t.string :email
  t.string :telephone
  t.boolean :waiting, :default => true
  t.text :notes
  t.timestamps
end

# Event Contacts
create_table :event_contacts do |t|
	t.references :event, :null => false
	t.references :contact, :null => false
	t.boolean :is_hostess, :default => false
end           

add_index :event_contacts, :event_id
add_index :event_contacts, :contact_id

# Friendships
create_table :friendships do |t|
  t.references :profile, :null => false
  t.integer :friend_id, :null => false    
  t.datetime :invited_at       
  t.datetime :accepted_at
  t.datetime :blocked_at
  t.timestamps
end

add_index :friendships, [:profile_id, :friend_id], :unique => true

# Friendships Requests
create_table :friendship_requests do |t|
  t.references :profile, :null => false
  t.integer :friend_id, :null => false
  t.text :notes
  t.timestamps
end

add_index :friendship_requests, [:profile_id, :friend_id], :unique => true

# Invite - TODO
        
# Messages
create_table :messages do |t|
  t.references :user, :null => false      
  t.string :message_type
  t.string :title, :null => false
  t.boolean :is_private, :default => false
  t.text :content
  t.datetime :deleted_at
  t.timestamps
end 

add_index :messages, :user_id

# Orders
create_table :orders do |t|
  t.references :user, :null => false
  t.references :contact
  t.string :order_type, :null => false, :default => 'in'
  t.text :notes            
  t.decimal :total_price, :precision => 8, :scale => 2, :null => false
  t.string :status, :default => 'open'
  t.datetime :ordered_at, :null => false, :default => Time.zone.now
  t.datetime :completed_at
  t.datetime :deleted_at
  t.timestamps
end

add_index :orders, :user_id
add_index :orders, :order_type
add_index :orders, :ordered_at

# OrderItems
create_table :order_items do |t|
  t.references :order, :null => false
  t.references :product, :null => false
  t.decimal :price, :precision => 8, :scale => 2, :null => false
  t.integer :quantity, :default => 1, :null => false
  t.string :status, :default => 'waiting'
  t.datetime :shipped_at
  t.timestamp
end

add_index :order_items, :order_id
add_index :order_items, :product_id

# Notifications
create_table :notifications do |t|
  t.references :user, :null => false
  t.string :notification_type
  t.string :description
  t.datetime :deleted_at
  t.timestamps
end

add_index :notifications, :user_id


# Payments
create_table :payments do |t|
  t.references :order, :null => false
  t.string :method, :default => 'gross_money'
  t.decimal :amount, :method => 8, :scale => 2, :null => false
  t.date :expected_at
  t.date :confirmation_at
  t.timestamps
end

add_index :payments, :order_id

