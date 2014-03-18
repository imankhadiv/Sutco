#
# show.rb
#
# Class to create a show. Each show has different show dates.
#

class Show < ActiveRecord::Base
  has_many :show_dates, :dependent => :destroy
  has_many :show_roles, :dependent => :destroy
  accepts_nested_attributes_for :show_dates, :allow_destroy => true
  accepts_nested_attributes_for :show_roles, :allow_destroy => true
  mount_uploader :image, ImageUploader
  validates :name, :director, :stage_manager, :producer, :synopsis, presence: true
  after_create :create_board
  has_one :board, :dependent => :destroy

  def create_board
    Board.create(:title => name, public: false, show_id: id)
  end

end
