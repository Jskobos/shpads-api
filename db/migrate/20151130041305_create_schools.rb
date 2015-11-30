class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :ipads
      t.references :teacher, index: true, foreign_key: true
      t.references :classroom, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
