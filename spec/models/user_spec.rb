require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(described_class.name.underscore.to_sym) }

  context "validations" do
    it("requires a name") { is_expected.to validate_presence_of(:name) }
    it("requires an email") { is_expected.to validate_presence_of(:email) }
    it("requires a unique email") { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  context "user methods" do
    it { is_expected.to respond_to(:name_email) }
    it { is_expected.to respond_to(:admin?) }
    it { is_expected.to respond_to(:super_admin?) }

    it "is not an admin" do
      expect(subject.admin?).to eq(false)
      expect(subject.super_admin?).to eq(false)
    end
  end
end
