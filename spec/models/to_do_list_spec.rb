require 'rails_helper'

RSpec.describe ToDoList, type: :model do
  context "associations" do
    it { should belong_to :user }
    it { should have_many :assignments }
    it { should have_many :favorite_to_do_lists }
  end

  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :list_type }
    it { should validate_presence_of :user_id }
  end

  context "scopes" do
    let(:user) { create(:user, :with_lists) }
    let!(:public_list) { create(:to_do_list, user: user, list_type: ToDoListTypes::PUBLIC) }

    describe ".public_lists" do
      it "returns ToDoList that are public" do
        expect(ToDoList.public_lists.to_a).to eq [public_list]
      end
    end

    describe ".dont_belong_to_user(user)" do
      let!(:another_user) { create(:user, :with_lists) }
      let(:another_user_list) { another_user.to_do_lists.first }

      it "returns ToDoList that dont belong to given user" do
        expect(ToDoList.dont_belong_to_user(user).to_a).to eq [another_user_list]
      end
    end
  end
end
