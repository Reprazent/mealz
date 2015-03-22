class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.references :payed_by, index: true, null: false
      t.float :amount, null: false, default: 0.0

      t.timestamps null: false
    end
    add_foreign_key :meals, :users, column: "payed_by_id"
  end
end
