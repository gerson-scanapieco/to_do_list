require 'rails_helper'

RSpec.describe FavoriteToDoList, type: :model do
  context "associations" do
    it { should belong_to :to_do_list }
    it { should belong_to :user }
  end

  context "delegations" do
    it { should delegate_method(:name).to(:to_do_list).with_prefix(true) }
  end
end
