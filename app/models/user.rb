class User < ActiveRecord::Base
  validates :firstname, :lastname, :course, :level, presence: true
  validates_format_of :email, :with => /.+@sheffield.ac.uk\z/
  #validates :ucard, :numericality => true
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

end
