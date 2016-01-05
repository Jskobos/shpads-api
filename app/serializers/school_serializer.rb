class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :ipads, :classrooms

  class SubTeacherSerializer < ActiveModel::Serializer
    attributes :name, :admin
  end

  has_many :teachers, serializer: SubTeacherSerializer
end
