class AddAnswergroupToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :answergroup, index: true, foreign_key: true
  end
end
