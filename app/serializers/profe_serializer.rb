class ProfeSerializer < ActiveModel::Serializer
  attributes :id, :ubicacion, :numero
  has_one :user
end
