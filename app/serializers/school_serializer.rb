class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :ipads
  has_many :teachers
  has_many :classrooms
end
