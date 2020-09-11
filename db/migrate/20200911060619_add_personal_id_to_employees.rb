class AddPersonalIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :personal_id, :integer
  end
end
