#
#   show_role.rb
#
# This class belongs to Show. Each Show has different roles. The ShowRole class is implemented to provide information about different roles.
#


class ShowRole < ActiveRecord::Base
  belongs_to :show
  has_many :role_applications, :dependent => :destroy
  validates :required_number, :numericality => { :greater_than => 0}
  validates :position, presence: true

  def notexpired?
     @returnvalue = false
    @dates = ShowDate.where(show_id: show.id)
    @dates.each do |showdate|
    if showdate.date.future?
      @returnvalue = true
     end
   end
   @returnvalue
  end

  def applied?(user)
     @returnvalue = false
    @applications = RoleApplication.where(show_role_id: id)
    @applications.each do |application|
    if application.user.id == user
      @returnvalue = true
     end
   end
   @returnvalue
  end

end
