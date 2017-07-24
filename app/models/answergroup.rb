class Answergroup < ActiveRecord::Base
  belongs_to :qcd
  attr_accessor :answer[1]
  validates :group,:answer[1], presence: true
  
  def answer_for_form
    collection = answers.where(answergroup: id)
    collection.any? ? collection : answers.build
  end
  
end
