class Qcd < ActiveRecord::Base
  belongs_to :asignatura
  has_many :answergroups
  enum estados: ["En Espera de Aprobacion", "Aprobado", "Revision", "Terminado", "No Aprobado"]
end
