class Task < ActiveRecord::Base 
  attr_accessible :title, :description, :due_date, :priority
end
