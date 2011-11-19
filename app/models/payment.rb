class Payment < ActiveRecord::Base
  # Associations
  belongs_to :order  
    
  # Validations
  CHECK = 'check'
  CREDIT_CARD = 'credit_card'
  GROSS_MONEY = 'gross_money'
  
  validates_numericality_of :amount, :greater_than_or_equal => 0
  validates_presence_of :order
  validates_inclusion_of :method, :in => [CHECK, CREDIT_CARD, GROSS_MONEY]
  
  # Scopes
  scope :between, lambda {|*dates| where("created_at between :start and :stop").where(:start, dates.first.to_date).where(:stop, dates.last.to_date)}
  scope :was_not_paid, where(:confirmation_at => nil)
  scope :by_overdue, lambda {|date| where("confirmation_at IS NULL AND expected_at < ?", date)}
  
  # Others

  
end

