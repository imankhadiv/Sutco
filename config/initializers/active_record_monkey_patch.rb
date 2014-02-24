class ActiveRecord::Base

  def date_cannot_be_in_the_past
  errors.add(:date, "can't be in the past") if
      !date.blank? and date < Date.today
  end

  def time_cannot_be_in_the_past
  errors.add(:time, "can't be in the past") if
      date == Date.today and !time.blank? and Time.parse(time.strftime("%I:%M%p"))<Time.parse(Time.now.strftime("%I:%M%p"))
  end

  def event_name
    "#{self.class}"
  end
end
