class Education < ActiveRecord::Base
  attr_accessible :tenth_school, :tenth_grade, :twelfth_school, :twelfth_grade, :ug_university, :ug_grade, :employee_id, :id
  belongs_to :employee
end