class Meal < ActiveRecord::Base
  belongs_to :payed_by, class_name: User.name
  validates :payed_by, presence: true
  validates :amount, presence: true
  validate :check_all_users
  has_and_belongs_to_many :users
  before_destroy :rollback_balance

  def check_all_users
    errors.add(:users, "has no eaters") if users.size < 2
    errors.add(:users, "does not contain the payer") unless users.include? payed_by
  end

  def rollback_balance
    users.each do |u|
      u.balance -= amount if u == payed_by
      u.balance += (amount / users.size)
      u.save!
    end
  end
end
