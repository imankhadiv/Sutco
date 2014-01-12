class Training < ActiveRecord::Base
  validates :title, :category, :description, :date, :duration, :time, presence: true
  validate :training_date_cannot_be_in_the_past
  validate :training_time_cannot_be_in_the_past
  validates :duration, numericality: {greater_than: 0 }



  def training_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
        !date.blank? and date < Date.today
  end
  def training_time_cannot_be_in_the_past
    errors.add(:time, "can't be in the past") if
        date == Date.today and !time.blank? and time < Time.now
  end
end
