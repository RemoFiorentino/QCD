class AddAnswerToAnswergroup < ActiveRecord::Migration
  def change
    add_column :answergroups, :answer, :string
  end
end
