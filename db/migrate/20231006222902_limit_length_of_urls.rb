class LimitLengthOfUrls < ActiveRecord::Migration[7.0]
  def change
    change_column :urls, :short, :string, limit: 10
    change_column :urls, :long, :string, limit: 2083
  end
end
