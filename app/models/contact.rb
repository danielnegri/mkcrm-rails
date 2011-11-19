class Contact < ActiveRecord::Base
  # Associations
  belongs_to :user  
  has_one :contact_detail, :dependent => :destroy
  has_many :contact_calls, :dependent => :destroy
  has_many :contact_nominees, :dependent => :destroy
  has_many :orders  
  
  accepts_nested_attributes_for :contact_detail, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }     
  
  # Attachment    
  AvatarSizes = {
    :micro => [32, 32],
    :thumb => [96, 96],
    :original => [256, 256]
  }
  
  styles = AvatarSizes.each_with_object({}) { |(name, size), all|
    all[name] = ["%dx%d%s" % [size[0], size[1], size[0] < size[1] ? '>' : '#'], :png]     
  }
  
  has_attached_file :avatar,
    :default_url => "/images/default-picture.png",
    :url => "/images/contacts/:id/:style.png",
    :path => ":rails_root/public/images/contacts/:id/:style.png",
    :styles => styles
  
  # Validations
  validates :name, :presence => true, :length => { :minimum => 3 }
  validates_attachment_size :avatar, :less_than => 10.megabytes
  validates_attachment_content_type :avatar, :content_type => %w[image/jpeg image/pjpeg image/png image/x-png image/gif]
  
  # Scopes
  scope :not_deleted, where(:deleted_at => nil)  
  scope :order_by_name, :order => :name 
  
  # Others
  def birthday
    if date_of_birth 
      now = Time.zone.now
      date = DateTime.civil(Time.zone.now.year, date_of_birth.month, date_of_birth.day, 0, 0, 0, 0)
    end
       
  end  
  
  def self.search(search)            
    if search && search.strip() != ''
      search = "%#{search}%".downcase()
      where('lower(name) LIKE :search OR lower(email) LIKE :search OR lower(telephone) LIKE :search OR lower(mobile_phone) LIKE :search OR lower(hostess) LIKE :search', :search => search)        
    else
      where('')
    end
  end  
  
  def deleted?
    !! deleted_at
  end
end
