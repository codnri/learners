class RenameSubjectColumnToTasks < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :subject, :title
  end
end
