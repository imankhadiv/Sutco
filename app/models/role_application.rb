class RoleApplication < ActiveRecord::Base
  belongs_to :show_role
  belongs_to :user
  validates :content, presence: true
  validates :show_role, uniqueness: {scope: :user, message: "You can only apply for this position once"}

  def self.get_unprocessed_applications
    applications = Array.new
    RoleApplication.all.each do |application|
       applications << application if ((application.status == "Pending") && (application.show_role.notexpired?))
    end
    applications 
  end
end
