class ToDoList < ActiveRecord::Base
  belongs_to :user
  has_many :assignments
  has_many :favorite_to_do_lists

  has_enumeration_for :list_type, with: ToDoListTypes, create_helpers: true

  accepts_nested_attributes_for :assignments, allow_destroy: true

  validates :name, :list_type, :user_id, presence: true

  scope :public_lists, -> { where(list_type: ToDoListTypes::PUBLIC) }
  scope :dont_belong_to_user, -> user { where.not(user_id: user.id) }

  def favorite?(user)
    self.favorite_to_do_lists.where(user_id: user).any?
  end

  def favorite_id(user)
    self.favorite_to_do_lists.where(user_id: user).take.id if favorite?(user)
  end
end
