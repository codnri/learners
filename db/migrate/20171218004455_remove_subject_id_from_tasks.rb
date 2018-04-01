class RemoveSubjectIdFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :subject_id
  end
end
