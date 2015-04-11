class FavoriteToDoList < ActiveRecord::Base
  belongs_to :to_do_list
  belongs_to :user
end
