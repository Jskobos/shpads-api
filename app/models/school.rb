class School < ActiveRecord::Base
  has_many :teachers
  serialize :classrooms, Array

  validates :name, presence: true, length: { within: 3..25 },
    uniqueness: { case_sensitive: false }, format: { with: /\A\S+\z/}
  validates :ipads, presence: true, numericality: { only_integer: true,
    less_than: 1000, greater_than: 0 }

  before_create -> {
    self.school_code = rand(1000...9999)
  }
end
