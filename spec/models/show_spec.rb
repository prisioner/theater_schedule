require 'rails_helper'

RSpec.describe Show, type: :model do
  describe "validations check" do
    describe "dates order check" do
      context "when end_date >= start date" do
        subject { build(:show, start_date: "2020-05-01", end_date: "2020-05-01") }

        it { is_expected.to be_valid }
      end

      context "when end_date < start_date" do
        subject { build(:show, start_date: "2020-05-02", end_date: "2020-05-01") }

        it { is_expected.not_to be_valid }
      end
    end

    describe "dates overlapping check" do
      before { create(:show, start_date: "2020-05-01", end_date: "2020-05-07" ) }

      context "when new show overlaps at start" do
        subject { build(:show, start_date: "2020-04-30", end_date: "2020-05-02") }

        it { is_expected.not_to be_valid }
      end

      context "when new show overlaps at end" do
        subject { build(:show, start_date: "2020-05-06", end_date: "2020-05-13") }

        it { is_expected.not_to be_valid }
      end

      context "when new show inside period" do
        subject { build(:show, start_date: "2020-05-03", end_date: "2020-05-04") }

        it { is_expected.not_to be_valid }
      end

      context "when new show overlaps whole period" do
        subject { build(:show, start_date: "2020-04-03", end_date: "2020-05-04") }

        it { is_expected.not_to be_valid }
      end

      context "when new show before existing" do
        subject { build(:show, start_date: "2020-04-03", end_date: "2020-04-30") }

        it { is_expected.to be_valid }
      end

      context "when new show after existing" do
        subject { build(:show, start_date: "2020-05-08", end_date: "2020-05-15") }

        it { is_expected.to be_valid }
      end
    end
  end
end
