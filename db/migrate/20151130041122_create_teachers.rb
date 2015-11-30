class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :email
      t.string :password
      t.string :auth_token
      t.boolean :admin
      t.references :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
