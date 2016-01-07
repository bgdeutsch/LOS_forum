class AddTitlesAndSackosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :titles, :integer
    add_column :users, :sackos, :integer
  end
end
