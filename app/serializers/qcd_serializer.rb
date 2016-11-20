class QcdSerializer < ActiveModel::Serializer
  attributes :id, :salon, :fecha, :grupo
  has_one :asignatura
end
