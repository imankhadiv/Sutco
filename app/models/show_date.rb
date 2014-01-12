class ShowDate < ActiveRecord::Base
  belongs_to :show
  validates :title, :date, :time, presence: true
  validate :show_date_cannot_be_in_the_past
  validate :show_time_cannot_be_in_the_past


  def show_date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
        !date.blank? and date < Date.today
  end
  def show_time_cannot_be_in_the_past
    errors.add(:time, "can't be in the past") if
        date == Date.today and !time.blank? and time < Time.now
  end
end
