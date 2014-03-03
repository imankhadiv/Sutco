class Board < ActiveRecord::Base
  has_many :conversations, dependent: :destroy
  validates :title, presence: true

end
