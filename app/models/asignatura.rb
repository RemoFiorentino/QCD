class Asignatura < ActiveRecord::Base
  belongs_to :user
  has_many :qcds, dependent: :destroy
end
