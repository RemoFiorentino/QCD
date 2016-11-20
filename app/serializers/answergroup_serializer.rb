class AnswergroupSerializer < ActiveModel::Serializer
  attributes :id
  has_one :qcd
end
