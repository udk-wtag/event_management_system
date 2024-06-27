class AddConstraintsToEvents < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :name, :string, null: false, limit: 100
    change_column :events, :location, :string, null: false, limit: 100
    change_column :events, :price, :decimal, null: false, default: 0.00
  end
end
