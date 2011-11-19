class ContactCall < ActiveRecord::Base
  # Associations
  belongs_to :contact  
  belongs_to :user
  
  # Validations
  validates :called_at, :presence => true
  
  EVALUATION = ['good', 'neutral', 'bad']    
  validates_inclusion_of :evaluation, :in => EVALUATION
  
  # Scopes
  scope :called_at, lambda {|date| where("called_at >=  :date", :date => date)} 
  
  # Others  
  def self.search(search)            
    if search && search.strip() != ''
      search = "%#{search}%".downcase()
      joins(:contact).where('lower(contact_calls.topic) LIKE :search OR lower(contacts.name) LIKE :search', :search => search)
    else
      where('')
    end
  end
  
end
