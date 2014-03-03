class RoleApplication < ActiveRecord::Base
  belongs_to :show_role
  belongs_to :user
  validates :content, presence: true
end
