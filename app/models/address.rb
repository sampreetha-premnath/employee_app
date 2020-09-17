class Address < ActiveRecord::Base
  attr_accessible :id, :first_line, :second_line, :city, :pincode, :employee_id, :name
  belongs_to :employee
end