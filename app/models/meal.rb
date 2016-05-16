class Meal < ActiveRecord::Base
  belongs_to :payed_by, class_name: User.name
  validates :payed_by, presence: true
  validates :amount, presence: true
  validate :check_all_users
  has_and_belongs_to_many :users
  scope :active, -> { where(cancelled_at: nil) }

  def check_all_users
    errors.add(:users, "has no eaters") if users.size < 2
    errors.add(:users, "does not contain the payer") unless users.include? payed_by
  end
end
