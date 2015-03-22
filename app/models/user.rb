class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :balance, presence: true
  has_many :payed_for_meals, class_name: Meal.name, foreign_key: :payed_by_id
  has_and_belongs_to_many :meals
end
