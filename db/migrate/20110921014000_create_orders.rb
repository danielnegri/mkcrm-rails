class CreateOrders < ActiveRecord::Migration
  def self.up
    # Orders
    create_table :orders do |t|
      t.references :user, :null => false
      t.references :contact
      t.string :order_type, :null => false, :default => 'out'      
      t.decimal :total_price, :precision => 8, :scale => 2, :null => false
      t.string :status, :default => 'open'
      t.text :notes            
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
  end

  def self.down
    drop_table :order_items
    drop_table :orders
  end
end




