class Conversation < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :board
  validates :title, :body, presence: true


end
