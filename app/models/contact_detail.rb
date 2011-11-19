class ContactDetail < ActiveRecord::Base
  # Associations
  belongs_to :contact
  
  # Validations
  SKIN_TYPES = ['normal', 'dry', 'mixed', 'oily']
  SKIN_TONES = ['ivory', 'beige', 'bronze']
  
  validates_inclusion_of :skin_type, :in => SKIN_TYPES
  validates_inclusion_of :skin_tone, :in => SKIN_TONES   
end
