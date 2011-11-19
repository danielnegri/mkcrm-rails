class Reminder < ActiveRecord::Base
  # Associations
  belongs_to :user
    
  # Validations
  TYPES = ['task', 'event', 'birthday', 'email']
  validates :title, :presence => true, :length => { :minimum => 3 }
  validates_presence_of :scheduled_at  
  validates_inclusion_of :reference_type, :in => TYPES
  
  # Scopes
  default_scope :order => :scheduled_at
  scope :scheduled_at, lambda {|date| where("scheduled_at >=  :date", :date => date)}
  scope :confirmed, where(:confirmed => true)
  scope :not_confirmed, where(:confirmed => false)  
  scope :overdue, where(:confirmed => false).where("scheduled_at <  :date", :date => Time.zone.now)
  
  # Others      
  def is_due
    (not confirmed) && scheduled_at < Time.zone.now
  end
  
  def self.search(search)            
    if search && search.strip() != ''
      search = "%#{search}%".downcase()
      where('lower(title) LIKE :search', :search => search).order(:title)      
    else
      where('')
    end
  end
end
