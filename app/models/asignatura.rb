class Asignatura < ActiveRecord::Base
  belongs_to :user
  has_many :qcds, dependent: :destroy
  def self.search(nrc, semestre)
    where("nrc LIKE #{nrc}", "semestre LIKE #{semestre}")
  end
end
