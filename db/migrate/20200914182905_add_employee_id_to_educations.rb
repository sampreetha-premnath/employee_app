class AddEmployeeIdToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :employee_id, :integer
  end
end
