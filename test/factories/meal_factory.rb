FactoryGirl.define do
  factory :meal do
    amount 15.0
    payed_by { FactoryGirl.build(:user) }
    users { [payed_by, FactoryGirl.build(:user)] }
  end
end
