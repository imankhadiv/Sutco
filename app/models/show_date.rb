#
#   show_date.rb
#
# This class belongs to Show. Each Show may take place in different dates. The ShowDate class is implemented to store those dates.
#
# ShowDate also has many fohs

class ShowDate < ActiveRecord::Base
  belongs_to :show
  has_many :fohs, :dependent => :destroy
  validates :date, :time, presence: true
  validates :date, uniqueness: true
  validate :date_cannot_be_in_the_past
  validate :time_cannot_be_in_the_past

  # GET show name
  def title
    show.name
  end

  # GET all front of house positions available
  def foh_available
    positions = Position.where.not(id: Position.joins(:fohs).where(fohs: {show_date_id: id}))
    # if no positions available, return false
    if positions.empty?
      return false
      # if date in the past, return false
    elsif self.date < Date.today
      return false
    else
      return true
    end
  end

  # do not allow date to be in the past 
  def time_cannot_be_in_the_past
    errors.add(:time, "can't be in the past") if
        date == Date.today and !time.blank? and Time.parse(time.strftime("%I:%M%p"))<Time.parse(Time.now.strftime("%I:%M%p"))
  end
end
