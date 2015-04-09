class Assignment < ActiveRecord::Base
  belongs_to :to_do_list

  validates :name, presence: true
end
