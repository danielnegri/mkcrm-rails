class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # Associations
  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  has_many :contacts, :dependent => :destroy
  has_many :contact_calls, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :inbox_messages, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :product_inventories, :dependent => :destroy
  has_many :reminders, :dependent => :destroy  
  
  
  after_create :create_default_profile
  
private
  def create_default_profile
    profile = Profile.new(:user_id => id)
    profile.name = /(.+)@/.match(email)[1]
    profile.save
  end
  
end
