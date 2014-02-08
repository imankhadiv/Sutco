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
