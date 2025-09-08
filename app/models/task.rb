class Task < ApplicationRecord
  validates :title, presence: true
  after_create_commit -> { broadcast_prepend_to "tasks_list", partial: "tasks/task", locals: { task: self }, target: "tasks-list" }
  after_update_commit -> { broadcast_replace_to "tasks_list", partial: "tasks/task", locals: { task: self } }
  after_destroy_commit -> { broadcast_remove_to "tasks_list" }
end
