#
# role_applications.rb
#
# Class to create a role application. Each role application belongs to a particular show role
#

class RoleApplication < ActiveRecord::Base
  belongs_to :show_role
  belongs_to :user
  validates :content, presence: true
  validates :show_role, uniqueness: {scope: :user, message: "You can only apply for this position once"}

  # GET unprocessed applications
  def self.get_unprocessed_applications
    applications = Array.new
    # store applications that have Pending status and non expired date
    RoleApplication.all.each do |application|
      applications << application if ((application.status == "Pending") && (application.show_role.notexpired?))
    end
    applications
  end
end
