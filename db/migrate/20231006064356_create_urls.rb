class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :short, not_null: true
      t.string :long, not_null: true, unique: true

      t.timestamps
    end
  end
end
