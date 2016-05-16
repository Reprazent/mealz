class MealDestroyer
  attr_accessor :meal

  def initialize(meal_id)
    return nil unless self.meal = Meal.find(meal_id)
  end

  def destroy_meal
    return nil unless meal
    if meal.update_attribute(:cancelled_at, Time.now)
      rollback_balances!
      remove_empty_users!
      meal.reload
    end
    meal
  end

  def rollback_balances!
    return nil unless meal
    meal.users.each do |u|
      u.balance -= meal.amount if u == meal.payed_by
      u.balance += (meal.amount / meal.users.size)
      u.save!
    end
  end

  def remove_empty_users!
    return nil unless meal
    meal.users.each do |u|
      next if u == meal.payed_by # Keep the owner of the meal. Perhaps we might want to nullify the meal here.
      u.meals.delete(meal) if u.meals.active.count == 0
      u.destroy if u.meals.active.count == 0
    end
  end
end
