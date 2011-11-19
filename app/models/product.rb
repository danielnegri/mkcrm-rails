class Product < ActiveRecord::Base
  # Associations
  has_many :order_items
  has_many :product_inventories
      
  # Attachment    
  AttachmentSizes = {
    :micro => [32, 32],
    :thumb => [96, 96],
    :product => [240, 240],
    :large => [600, 600]
  }
  
  styles = AttachmentSizes.each_with_object({}) { |(name, size), all|
    all[name] = ["%dx%d%s" % [size[0], size[1], size[0] < size[1] ? '>' : '#'], :png]     
  }
  
  has_attached_file :attachment,
    :default_url => "/images/default-product.png",
    :url => "/images/products/:id/:style.png",
    :path => ":rails_root/public/images/products/:id/:style.png",
    :styles => styles
  
  # Validations
  validates_presence_of :name
  validates_length_of :name, :minimum => 3
  validates_numericality_of :price
  validates_uniqueness_of :sku
  validates_attachment_size :attachment, :less_than => 2.megabytes
  validates_attachment_content_type :attachment, :content_type => %w[image/jpeg image/pjpeg image/png image/x-png image/gif]
  
  # Scopes
  default_scope :order => :name
  scope :not_deleted, where(:deleted_at => nil)
      
  # Others
  def attachment_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(attachment.path(style))
  end  
  
  def self.search(search)            
    if search && search.strip() != ''
      search = "%#{search}%".downcase()
      where('lower(name) LIKE :search OR lower(description) LIKE :search OR lower(sku) LIKE :search', :search => search).order(:name)
    else
      order("updated_at desc")  
    end
  end

end
