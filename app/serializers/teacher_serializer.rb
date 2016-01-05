class TeacherSerializer < ActiveModel::Serializer
  attributes :id, :name, :admin

  class SubSchoolSerializer < ActiveModel::Serializer
    has_many :classrooms
    attributes :name, :ipads
  end

  has_one :school, serializer: SubSchoolSerializer
end
