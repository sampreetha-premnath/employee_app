class RemoveEmployeeIdFromPersonals < ActiveRecord::Migration
  def change
    remove_column :personals, :employee_id
  end
end
