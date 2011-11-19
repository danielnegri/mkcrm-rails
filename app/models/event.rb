class Event < ActiveRecord::Base
  # Associations
  belongs_to :user    
  has_many :event_reminders
  has_many :reminders, :through => :event_reminders
  
  # Validations
  SHOW_AS = ['busy', 'available']
  PRIVACY = ['public', 'private']
  
  validates_presence_of :title, :start_at, :end_at  
  validates_length_of :title, :minimum => 3
  validates_inclusion_of :show_as, :in => SHOW_AS
  validates_inclusion_of :privacy, :in => PRIVACY 
  
  # Scopes
  default_scope :order => :start_at
  scope :started_at, lambda {|date| where("start_at >=  :date", :date => date)}
  scope :not_deleted, where(:deleted_at => nil)
  
  # Others  
  def self.search(search)   
         
    if search && search.strip() != ''
      search = "%#{search}%".downcase()
      where('lower(title) LIKE :search OR lower(location) LIKE :search', :search => search).order(:title)      
    else
      where('')
    end
  end         
end
