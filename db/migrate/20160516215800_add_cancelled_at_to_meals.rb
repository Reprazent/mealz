class AddCancelledAtToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :cancelled_at, :datetime
  end
end
