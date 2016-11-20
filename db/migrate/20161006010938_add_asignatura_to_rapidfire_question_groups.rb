class AddAsignaturaToRapidfireQuestionGroups < ActiveRecord::Migration
  def change
    add_column :rapidfire_question_groups, :asignatura, :reference
  end
end
