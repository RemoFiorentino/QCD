class Qcd < ActiveRecord::Base
  belongs_to :asignatura
  has_many :answergroups
end
