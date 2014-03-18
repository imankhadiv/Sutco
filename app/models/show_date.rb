#
#   show_date.rb
#
# This class belongs to Show. Each Show may take place in different dates. The ShowDate class is implemented to store those dates.
# ShowDate also has many fohs

class ShowDate < ActiveRecord::Base
  belongs_to :show
  has_many :fohs, :dependent => :destroy
  validates :date, :time, presence: true
  validates :date, uniqueness: true
  validate :date_cannot_be_in_the_past
  validate :time_cannot_be_in_the_past

  def title
    show.name
  end

  def foh_available
    # @show_date = ShowDate.find(params[:show_date_id])
    positions = Position.where.not(id: Position.joins(:fohs).where(fohs: {show_date_id: id}))
    if positions.empty?
      return false
    else
      return true
    end
  end

  def time_cannot_be_in_the_past
    errors.add(:time, "can't be in the past") if
        date == Date.today and !time.blank? and Time.parse(time.strftime("%I:%M%p"))<Time.parse(Time.now.strftime("%I:%M%p"))
  end
end
