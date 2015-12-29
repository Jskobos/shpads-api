class TeacherSerializer < ActiveModel::Serializer
  attributes :id, :name, :admin, :school_id
end
