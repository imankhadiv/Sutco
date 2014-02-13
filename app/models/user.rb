# user.rb
#
# This is the model class for User. It makes use of the devise gem, contains validations for the user and also
# contains additional methods for authentication and user roles.
#
#

class User < ActiveRecord::Base
  validates :firstname, :lastname, :level, :course, presence: true
  validates_format_of :email, :with => /.+@sheffield.ac.uk\z/
  validates :ucard, :numericality => true
  has_and_belongs_to_many :roles
  has_many :training_records

  # enable the required devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #user can only login if he has been approved
  def active_for_authentication?
    super && approved?
  end

  #message to be displayed if the user has signed up but is not yet approved
  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  #class method that returns list of users awaiting approval
  def self.not_approved
    User.where(:approved => false)
  end

  #class method that returns list of users already approved
  def self.approved
    User.where(:approved => true)
  end

  #returns true if the string passed to it is the role belonging to the user
  #It is used by the CanCan ability class
  def role?(role_string)
    return !!self.roles.find_by_name(role_string.to_s.camelize)
  end

  #Returns the roles which belong to the user with the specified id
  def self.user_role(id)
    user = User.find_by_id(id)
    user.roles
  end

  def self.get_users user_ids
    users = Array.new
    user_ids.each do |id|
      users << User.where(id:user_ids)
    end
    users
  end


end
