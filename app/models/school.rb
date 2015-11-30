class School < ActiveRecord::Base
  has_many :teachers
  has_many :classrooms
end
