class User < ActiveRecord::Base
  validates :firstname, :lastname, :level, :course, presence: true
  validates_format_of :email, :with => /.+@sheffield.ac.uk\z/
  validates :ucard, :numericality => true
  has_and_belongs_to_many :roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end
  def self.not_approved
    User.where(:approved => false)
  end

  def self.approved
    User.where(:approved => true)
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def self.user_role id
    user = User.where(id: id)
    user.roles

  end

end
