class Order < ActiveRecord::Base
  # Associations
  belongs_to :user  
  has_one :contact  
  has_many :order_items, :dependent => :destroy
  has_many :payments
  
  accepts_nested_attributes_for :order_items
  
  # Validations  
  validates_presence_of :contact  
  
  INVENTORY_TYPES = ['in', 'out']
  validates_inclusion_of :inventory_type, :in => INVENTORY_TYPES
  
  STATUS = ['open', 'pending_with_problems', 'concluded', 'canceled']
  validates_inclusion_of :status, :in => STATUS
  
  validates_length_of :order_items, :minimum => 0 # :message => 'please enter at least 1 item'
  
  # Scopes
  # default_scope order('created_at')
  scope :not_deleted, where(:deleted_at => nil)  
  scope :ordered_at, lambda {|date| where("ordered_at >=  :date", :date => date)}
  scope :by_type, lambda{|type| where('type = ?', type)}
  scope :by_status, lambda{|status| where('status = ?', status)}  
  
  # Others  
  def self.search(search)            
    if search && search.strip() != ''
      search = "%#{search}%".downcase()
      joins(:contact).where('lower(orders.notes) LIKE :search OR lower(contacts.name) LIKE :search', :search => search)
    else
      where('')
    end
  end
  
end
