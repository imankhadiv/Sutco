class Social < ActiveRecord::Base
  validates :title, :location, :description, :date, :duration, :time, presence: true
  validate :date_cannot_be_in_the_past
  validate :time_cannot_be_in_the_past
  validates :duration, numericality: {greater_than: 0, less_than_or_equal_to: 600}

end