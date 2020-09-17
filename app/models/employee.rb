class Employee < ActiveRecord::Base
  attr_accessible :employee_id, :employee_name, :employee_email, :squad_id, :squad, :personal_id
  belongs_to :squad
  has_one :personal
  serialize :address
  accepts_nested_attributes_for :squad
  validates_presence_of :employee_id
end
