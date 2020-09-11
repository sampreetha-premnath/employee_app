class Squad < ActiveRecord::Base
  attr_accessible :squad_name, :employees
  has_many :employees
  accepts_nested_attributes_for :employees
end
