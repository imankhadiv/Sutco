class RoleApplication < ActiveRecord::Base
  belongs_to :show_role
  belongs_to :user
  validates :content, presence: true
  validates :show_role, uniqueness: {scope: :user, message: "You can only apply for this position once"}
end
