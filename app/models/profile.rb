class Profile < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :friendships, :dependent => :destroy  
  has_many :friendship_requests, :dependent => :destroy
  
  # Attachment    
  AvatarSizes = {
    :micro => [32, 32],
    :thumb => [64, 64],
    :profile => [128, 128] # 180x180
  }
  
  styles = AvatarSizes.each_with_object({}) { |(name, size), all|
    all[name] = ["%dx%d%s" % [size[0], size[1], size[0] < size[1] ? '>' : '#'], :png]     
  }
  
  has_attached_file :avatar,
    :default_url => "/images/default-profile.png",
    :url => "/images/profiles/:id/:style.png",
    :path => ":rails_root/public/images/profiles/:id/:style.png",
    :styles => styles
  
  # Validations
  validates_presence_of :name
  validates_length_of :name, :minimum => 3
  validates_attachment_size :avatar, :less_than => 10.megabytes
  validates_attachment_content_type :avatar, :content_type => %w[image/jpeg image/pjpeg image/png image/x-png image/gif]
  
  # Scopes
  scope :not_deleted, where(:deleted_at => nil)  
  default_scope :order => :name
  
  # Others
  def position    
    self[:position] = "Consultora" if self[:position].blank?
    self[:position]
  end
  
  def self.search(search)            
    if search && search.strip() != ''
      search = "%#{search}%".downcase()
      where('lower(name) LIKE :search OR lower(position) LIKE :search OR lower(code) LIKE :search', :search => search)        
    else
      where('')
    end
  end
    
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  LOCALES_CODES = I18n.available_locales.map(&:to_s)  
  def locale 
    if LOCALES_CODES.include? self[:language]
      self[:language]
    else
      I18n.default_locale.to_s
    end
  end
end
