class AddShortIndexToUrl < ActiveRecord::Migration[7.0]
  def change
    add_index :urls, :short, unique: true
  end
end
