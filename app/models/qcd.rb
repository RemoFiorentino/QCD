class Qcd < ActiveRecord::Base
  belongs_to :asignatura
  has_many :answergroups
  enum estados: ["En Espera de Aprobacion", "Aprobado", "Revision", "Terminado", "No Aprobado"]
  def Informe(qcd)
    link_to informe,  asignatura_qcd_path(qcd.id)
  end
end
