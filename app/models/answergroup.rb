class Answergroup < ActiveRecord::Base
  belongs_to :qcd
  has_many :answers
  accepts_nested_attributes_for :answers
  
  def answer_for_form
    collection = answers.where(answergroup: id)
    collection.any? ? collection : answers.build
  end
  
end
