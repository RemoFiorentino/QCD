class Asignatura < ActiveRecord::Base
  belongs_to :user
  has_many :qcds, dependent: :destroy
  validates :nombre, presence: true, length: { minimum: 3, maximum: 40 }
  validates :nrc, presence: true, length: { minimum: 4, maximum: 4}
  validates :division,:dpto,:programa,:semestre,:creditos,:objetivo1,:num_estud, presence: true
  def self.search(nrc, semestre)
    where("nrc LIKE #{nrc}", "semestre LIKE #{semestre}")
  end
end
