require 'rails_helper'
require_relative './examples/display_name'

RSpec.describe Project, type: :model do
  subject { build(described_class.name.underscore.to_sym) }

  context "validations" do
    it("requires a year") { is_expected.to validate_presence_of(:year) }
    it("requires a name") { is_expected.to validate_presence_of(:name) }
    it("requires a start time") { is_expected.to validate_presence_of(:start_time) }
    it("requires an end time") { is_expected.to validate_presence_of(:end_time) }
    it("requires a max upload size") { is_expected.to validate_presence_of(:max_upload_size) }
    it("requires a valid max upload size") do
      is_expected.to validate_numericality_of(:max_upload_size).is_greater_than(0).is_less_than_or_equal_to(Rails.configuration.x.apitp.max_upload_size)
    end
    it("requires an owner") { is_expected.to validate_presence_of(:owner) }
  end

  include_examples :display_name
end
