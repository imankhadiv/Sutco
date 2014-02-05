class Social < ActiveRecord::Base
  validates :title, :location, :description, :date, :duration, :time, presence: true
  validate :social_date_cannot_be_in_the_past
  validate :social_time_cannot_be_in_the_past
  validates :duration, numericality: {greater_than: 0 }


  def social_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
        !date.blank? and date < Date.today
  end
  def social_time_cannot_be_in_the_past
    errors.add(:time, "can't be in the past") if
        date == Date.today and !time.blank? and time < Time.now
  end
  def return_type
    "social"
  end
end