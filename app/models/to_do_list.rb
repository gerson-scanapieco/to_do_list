class ToDoList < ActiveRecord::Base
  belongs_to :user

  has_enumeration_for :list_type, with: ToDoListTypes, create_helpers: true

  validates :name, :list_type, :user_id, presence: true
end
