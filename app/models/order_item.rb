class OrderItem < ActiveRecord::Base
  # Associations
  belongs_to :order  
  has_one :product
  
  # Validations  
  STATUS = ['waiting', 'pending_with_problems', 'shipped']
  
  validates_presence_of :order
  validates_presence_of :product
  validates_numericality_of :price, :greater_than => 0
  validates_numericality_of :quantity, :greater_than => 0, :only_integer => true
  validates_inclusion_of :status, :in => STATUS
  
  # Callbacks
  
  
  # Scopes
  scope :by_status, lambda{|status| where('status = ?', status)}  
  
  
  # Others  
  def order_type
    return nil unless self.order
    self.order.type
  end  
end
