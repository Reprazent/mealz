class Meal < ActiveRecord::Base
  belongs_to :payed_by, class_name: User.name
  validates :payed_by, presence: true
end
