require "rails_helper"
require "mogec/userrank_updater"

# patterns
# - order_price 0(normal)
# - order_price 10000(normal)
# - order_price 10001(bronze)
# - order_price 30000(bronze)
# - order_price 30001(silver)
# - order_price 70000(silver)
# - order_price 70001(gold)
# - order_price 100000(gold)
# - order_price 100001(pratinum)
RSpec.describe Mogec::UserRankUpdater do
  describe "#run" do
    subject(:user_rank) { user.reload.rank }
    let(:options) { { user: user.id } }

    before do
      Mogec::UserRankUpdater.new(options).run
    end

    context "when user purchased 0 yen" do
      let(:user) { FactoryBot.create(:user) }

      it "user's rank should be normal" do
        is_expected.to eq "normal"
      end
    end

    context "when user purchased 10000 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 10000) }

      it "user's rank should be normal" do
        is_expected.to eq "normal"
      end
    end

    context "when user purchased 10001 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 10001) }

      it "user's rank should be bronze" do
        is_expected.to eq "bronze"
      end
    end

    context "when user purchased 30000 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 30000) }

      it "user's rank should be bronze" do
        is_expected.to eq "bronze"
      end
    end

    context "when user purchased 30001 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 30001) }

      it "user's rank should be silver" do
        is_expected.to eq "silver"
      end
    end
  end
end
