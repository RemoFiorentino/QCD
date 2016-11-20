class Asignatura < ActiveRecord::Base
  belongs_to :profe
  has_many :qcds, dependent: :destroy
end
