module RemindersHelper
  def current_reminders
    now = Time.zone.now
    today = Date.new(now.year, now.month, now.day)
    reminders = current_user.reminders.where("scheduled_at >= :today or confirmed = :confirmed", :today => today, :confirmed => false).limit(10)
  end
end
