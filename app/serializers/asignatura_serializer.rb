class AsignaturaSerializer < ActiveModel::Serializer
  attributes :id, :division, :dpto, :programa, :nombre, :nrc, :semestre, :creditos, :objetivo1, :objetivo2, :objetivo3, :objetivo4, :objetivo5, :objetivo6, :objetivo7, :objetivo8, :objetivo9, :objetivo10
  has_one :profe
end
