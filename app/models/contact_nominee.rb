class ContactNominee < ActiveRecord::Base 
  # Associations
  belongs_to :contact
    
  # Validations
  validates_presence_of :name
  validates_length_of :name, :minimum => 3
end
