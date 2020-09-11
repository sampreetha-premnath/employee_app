class CreatePersonals < ActiveRecord::Migration
  def change
    create_table :personals do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :gender
      t.string :nativity
      t.string :phone_number
      t.string :work_number
      t.integer :employee_id
    end
  end
end
