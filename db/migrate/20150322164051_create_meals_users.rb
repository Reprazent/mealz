class CreateMealsUsers < ActiveRecord::Migration
  def change
    create_table :meals_users do |t|
      t.references :meal, index: true, null: false
      t.references :user, index: true, null: false
    end
    add_foreign_key :meals_users, :meals
    add_foreign_key :meals_users, :users
  end
end
