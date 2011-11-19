class CreateProducts < ActiveRecord::Migration
  def self.up
    # Products
    create_table :products do |t| 
      t.string :name, :null => false      
      t.text :description
      t.string :sku
      t.decimal :price, :precision => 8, :scale => 2, :null => false            
      t.datetime :deleted_at      
      t.string :attachment_file_name
      t.string :attachment_content_type      
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
      t.timestamps
    end

    add_index :products, :name
    add_index :products, :description
    add_index :products, :sku, :unique => true  

    # Product Inventories
    create_table :product_inventories do |t|
      t.references :user, :null => false
      t.references :product, :null => false
      t.integer :max, :default => 1
      t.integer :min, :default => 0
      t.integer :count, :default => 0
      t.timestamps
    end   

    add_index :product_inventories, [:user_id, :product_id], :unique => true


    # Reminders
    create_table :reminders do |t|
      t.references :user, :null => false
      t.string :title
      t.text :description
      t.integer :reference_id
      t.string :reference_type, :default => 'task'
      t.datetime :scheduled_at, :null => false
      t.boolean :confirmed, :default => false
      t.timestamps
    end

    add_index :reminders, :user_id
    add_index :reminders, :reference_id
    add_index :reminders, :scheduled_at
    add_index :reminders, :confirmed
  end

  def self.down
    drop_table :product_inventories
    drop_table :products
    drop_table :reminders
  end
end
