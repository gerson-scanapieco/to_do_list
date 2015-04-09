class ToDoList < ActiveRecord::Base
  belongs_to :user
  has_many :assignments

  has_enumeration_for :list_type, with: ToDoListTypes, create_helpers: true

  validates :name, :list_type, :user_id, presence: true

  scope :public_lists, -> { where(list_type: ToDoListTypes::PUBLIC) }
end
