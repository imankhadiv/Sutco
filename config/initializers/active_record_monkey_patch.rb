class ActiveRecord::Base

  def date_cannot_be_in_the_past
  errors.add(:date, "can't be in the past") if
      !date.blank? and date < Date.today


  end
  def time_cannot_be_in_the_past
  errors.add(:time, "can't be in the past") if
      date == Date.today and !time.blank? and time < Time.now
  end

  def event_name
    "#{self.class}"
  end
end
