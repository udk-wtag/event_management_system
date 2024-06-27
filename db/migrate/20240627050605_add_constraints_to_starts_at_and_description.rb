class AddConstraintsToStartsAtAndDescription < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :starts_at, :datetime, null: false
    change_column :events, :description, :text, null: false
  end
end
