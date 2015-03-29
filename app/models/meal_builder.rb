class MealBuilder
  attr_accessor :meal_params, :meal

  def initialize(meal_params)
    @meal_params = meal_params
  end

  def create_meal
    build_meal
    if meal.save
      recalculate_balances!
      meal.reload
    end
    meal
  end

  def recalculate_balances!
    return unless meal
    meal.users.each do |u|
      u.balance += meal.amount if u == meal.payed_by
      u.balance -= meal.amount / meal.users.size
      u.save!
    end
  end

  def build_meal
    self.meal = Meal.new.tap do |meal|
      meal.raw_params = meal_params
      meal.payed_by = payed_by
      meal.users = users
      meal.amount = amount
    end
  end

  def amount
    return nil unless meal_params[:amount]
    amount = meal_params[:amount].gsub(",", ".").to_f
    amount > 0 ? amount : nil
  end

  def payer_name
    return "" unless meal_params[:payed_by_username]
    normalize_username(meal_params[:payed_by_username])
  end

  def payed_by
    @payer ||= User.find_or_create_by(username: payer_name)
  end

  def eater_names
    return [] unless meal_params[:eater_names] && meal_params[:eater_names].is_a?(Array)
    meal_params[:eater_names].collect { |name| normalize_username(name) }.uniq
  end

  def users
    @users ||= build_users
  end

  def build_users
    users = eater_names.collect { |name| User.find_or_create_by(username: name) }
    users << payed_by
    users.uniq
  end

  def normalize_username(username)
    username.downcase.strip
  end
end
