class ShowRole < ActiveRecord::Base
  belongs_to :show
  validates :available_number, :required_number, :name, :position, :show, presence: true
  validates :available_number, :required_number, :numericality => { :greater_than => 0}

end
