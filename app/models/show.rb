class Show < ActiveRecord::Base
 has_many :show_dates, :dependent => :destroy
  accepts_nested_attributes_for :show_dates, :allow_destroy => true
end
