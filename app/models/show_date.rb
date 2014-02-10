#
#   show_date.rb
#
# This class belongs to Show. Each Show may take place in different dates. The ShowDate class is implemented to store those dates.
# ShowDate also has many fohs

class ShowDate < ActiveRecord::Base
  belongs_to :show
  has_many :fohs, :dependent => :destroy
  validates :date, :time, presence: true
  validate :date_cannot_be_in_the_past
  validate :time_cannot_be_in_the_past

  def title
    show.name
  end

end
