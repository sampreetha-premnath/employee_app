class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :employee_id
      t.string :employee_name
      t.string :employee_email
      t.timestamps null:false
    end
  end
end
