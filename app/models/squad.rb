class Squad < ActiveRecord::Base
  attr_accessible :squad_name
  has_many :employees
end
