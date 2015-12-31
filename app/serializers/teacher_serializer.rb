class TeacherSerializer < ActiveModel::Serializer
  attributes :id, :name, :admin

  class SubSchoolSerializer < ActiveModel::Serializer
    attributes :name, :ipads
  end

  has_one :school, serializer: SubSchoolSerializer


end
