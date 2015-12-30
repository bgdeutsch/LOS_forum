class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar_url
      t.string :password_digest
      t.boolean :isadmin, default: false

      t.timestamps null: false
    end
  end
end
