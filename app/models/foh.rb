class Foh < ActiveRecord::Base
  belongs_to :show_date
  belongs_to :position
  belongs_to :user

  validates :position, :user, :phone_number, presence: true
  validates :phone_number, :numericality => true, :length => { :minimum => 10, :maximum => 11 }

end
