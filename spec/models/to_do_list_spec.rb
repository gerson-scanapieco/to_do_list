require 'rails_helper'

RSpec.describe ToDoList, type: :model do
  context "associations" do
    it { should belong_to :user }
  end

  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :list_type }
    it { should validate_presence_of :user_id }
  end
end
