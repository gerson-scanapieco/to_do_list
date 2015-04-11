class FavoriteToDoList < ActiveRecord::Base
  belongs_to :to_do_list
  belongs_to :user

  delegate :name, to: :to_do_list, prefix: true
end
