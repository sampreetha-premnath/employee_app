class Personal < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :dob, :gender, :nativity, :phone_number, :work_number, :id
  belongs_to :employee
end
