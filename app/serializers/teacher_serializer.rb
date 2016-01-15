class TeacherSerializer < ActiveModel::Serializer
  attributes :id, :name, :admin

  class TeacherListSerializer < ActiveModel::Serializer
    attributes :name
  end

  class SubSchoolSerializer < ActiveModel::Serializer
    has_many :classrooms
    has_many :teachers, serializer: TeacherListSerializer
    attributes :name, :ipads
  end

  has_one :school, serializer: SubSchoolSerializer
end
