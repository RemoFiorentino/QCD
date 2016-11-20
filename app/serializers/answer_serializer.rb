class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :order, :answer
  has_one :qcd
end
