class Training < ActiveRecord::Base
  validates :title, :category, :description, :date, :duration, :time, presence: true
  validate :date_cannot_be_in_the_past
  validate :time_cannot_be_in_the_past
  validates :duration, numericality: {greater_than: 0 }

  has_many :training_records


end
