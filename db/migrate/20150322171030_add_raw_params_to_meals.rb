class AddRawParamsToMeals < ActiveRecord::Migration
  def up
    # For just a little while `alter role mealz superuser;`
    enable_extension :hstore
    add_column :meals, :raw_params, :hstore
  end

  def down
    disableenable_extension :hstore
    remove_column :meals, :raw_params
  end
end
