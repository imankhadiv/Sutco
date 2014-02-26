class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  validates :body, presence: true

end
