require 'rails_helper'
require "cancan/matchers"

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many :to_do_lists }
  end

  context "authorizations" do
    context "user authorizations" do
      let!(:user) { create(:user) }
      let!(:another_user) { create(:user) }
      subject(:ability) { Ability.new(user) }

      it { should have_abilities([:read, :update], user) }
      it { should have_abilities(:read, another_user) }

      it { should not_have_abilities([:update, :edit, :destroy], another_user) }
    end

    context "to_do_lists authorizations" do
      let!(:user) { create(:user, :with_lists) }
      let!(:user_list) { user.to_do_lists.last }

      let!(:another_user) { create(:user, :with_lists) }
      let!(:another_user_list) { another_user.to_do_lists.last }
      let!(:another_user_public_list) { create(:to_do_list, list_type: ToDoListTypes::PUBLIC, user: another_user) }

      subject(:ability) { Ability.new(user) }

      it { should have_abilities(:manage, user_list) }
      it { should have_abilities(:read, another_user_public_list) }

      it { should not_have_abilities(:read, another_user_list) }
      it { should not_have_abilities(:manage, another_user_list) }
      it { should not_have_abilities(:manage, another_user_public_list) }
    end

    context "assignments authorizations" do
      let!(:user) { create(:user, :with_lists) }
      let!(:user_list) { user.to_do_lists.last }
      let!(:user_list_assignment) { create(:assignment, to_do_list: user_list) }

      let!(:another_user) { create(:user, :with_lists) }
      let!(:another_user_list) { another_user.to_do_lists.last }
      let!(:another_user_list_assignment) { create(:assignment, to_do_list: another_user_list) }

      let!(:another_user_public_list) { create(:to_do_list, list_type: ToDoListTypes::PUBLIC, user: another_user) }
      let!(:another_user_public_list_assignment) { create(:assignment, to_do_list: another_user_public_list) }

      subject(:ability) { Ability.new(user) }

      it { should have_abilities(:manage, user_list_assignment) }

      it { should have_abilities(:read, another_user_public_list_assignment) }

      it { should not_have_abilities( [:read, :update, :destroy], another_user_list_assignment) }
    end
  end
end
