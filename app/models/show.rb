#
# show.rb
#
# Class to create a show. Each show has different show dates and show roles.
#

class Show < ActiveRecord::Base
  has_many :show_dates, :dependent => :destroy
  has_many :show_roles, :dependent => :destroy
  accepts_nested_attributes_for :show_dates, :allow_destroy => true
  accepts_nested_attributes_for :show_roles, :allow_destroy => true
  mount_uploader :image, ImageUploader # allow image upload
  validates :name, :director, :stage_manager, :producer, :synopsis, presence: true
  validate :show_dates_must_be_unique
  after_create :create_board
  has_one :board, :dependent => :destroy

  def create_board
    Board.create(:title => name, public: false, show_id: id)
  end

  # create shows with unique show dates
  def show_dates_must_be_unique
    errors.add(:show_dates, "can't be duplicated") unless
        show_dates.map(&:date).uniq.count == show_dates.to_a.count
  end

end
