class RemoveReferenceFromSchool < ActiveRecord::Migration
  def change
    remove_column :schools, :teacher_id, :integer
    remove_column :schools, :classroom_id, :integer
  end
end
