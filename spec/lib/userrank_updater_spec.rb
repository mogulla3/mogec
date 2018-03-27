require "rails_helper"
require "mogec/userrank_updater"

RSpec.describe Mogec::UserRankUpdater do
  describe "#run" do
    subject(:user_rank) { user.reload.rank }
    let(:options) { { user: user.id } }

    before do
      Mogec::UserRankUpdater.new(options).run
    end

    context "when user purchased 0 yen" do
      let(:user) { FactoryBot.create(:user_0) }

      it "user's rank should be normal" do
        is_expected.to eq "normal"
      end
    end

    context "when user purchased 10000 yen" do
      let(:user) { FactoryBot.create(:user_10000) }

      it "user's rank should be normal" do
        is_expected.to eq "normal"
      end
    end

    context "when user purchased 10001 yen" do
      let(:user) { FactoryBot.create(:user_10001) }

      it "user's rank should be bronze" do
        is_expected.to eq "bronze"
      end
    end

    context "when user purchased 30001 yen" do
      let(:user) { FactoryBot.create(:user_30001) }

      it "user's rank should be silver" do
        is_expected.to eq "silver"
      end
    end
  end
end
