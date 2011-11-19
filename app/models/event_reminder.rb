class EventReminder < ActiveRecord::Base
  belongs_to :event
  belongs_to :reminder
end
