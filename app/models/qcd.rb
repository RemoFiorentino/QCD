class Qcd < ActiveRecord::Base
  belongs_to :asignatura
  has_many :answergroups
  enum estados: ["En Espera de Aprobacion", "Aprobado", "Revision", "Terminado", "No Aprobado"]
  def Informe(qcd)
    link_to informe,  asignatura_qcd_path(qcd.id)
  end
  
  after_update :send_mail
  def send_mail
    if( self.estados != 0)
      Mailer.profe_email(self.asignatura.user,self).deliver
    end
  end
end
