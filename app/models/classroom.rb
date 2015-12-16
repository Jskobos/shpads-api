class Classroom < ActiveRecord::Base
  belongs_to :school

  validates :name, presence: true, length: { within: 1..25 }
end
