class AddSubjectIdToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :subject, foreign_key: true
  end
end
