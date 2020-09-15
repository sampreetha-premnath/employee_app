class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :tenth_school
      t.float :tenth_grade
      t.string :twelfth_school
      t.float :twelfth_grade
      t.string :ug_university
      t.float :ug_grade
    end
  end
end
