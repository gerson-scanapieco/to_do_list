require 'rails_helper'

RSpec.describe Assignment, type: :model do
  context "associations" do
    it { should belong_to :to_do_list }
  end

  context "validations" do
    it { should validate_presence_of :name }
  end
end
