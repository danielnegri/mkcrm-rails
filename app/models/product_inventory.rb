class ProductInventory < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :product    
  
  # Validations
  validates_presence_of :user, :product, :count, :max, :min, :count
  validates_numericality_of :max, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :min, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :count, :only_integer => true, :greater_than_or_equal_to => 0  
  
  # Scopes
  scope :out_of_stock, where('min >= count')
      
  # Others   
  def availability        
    value = 0
    max = self[:max].to_f
    count = self[:count].to_f
    min = self[:min].to_f
    if max - min > 0
      value = ((count - min)/(max-min)  * 100.00).ceil      
      value = 100.00 if value > 100.00      
    end
    
    return value
  end
  
  def out_of_stock?
    self[:min] >= self[:count] 
  end
  
  def self.search(search)            
    if search && search.strip() != ''
      search = "%#{search}%".downcase()
      joins(:product).where('lower(name) LIKE :search OR lower(description) LIKE :search OR lower(sku) LIKE :search', :search => search).order(:name)
    else
      joins(:product).order(:name)
    end
  end
end
