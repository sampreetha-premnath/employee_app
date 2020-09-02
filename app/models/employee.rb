class Employee < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :squad
  validates_presence_of :employee_id
end
