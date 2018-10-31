class User < ActiveRecord::Migration[5.2]
  def change
    create_table :user do |t|
      t.string :name
      t.string :email
      t.integer :uid

      t.timestamps
    end
  end
end
