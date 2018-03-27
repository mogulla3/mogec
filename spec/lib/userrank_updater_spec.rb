require "rails_helper"
require "mogec/userrank_updater"

# patterns
# - [x] order_price 0(normal)
# - [x] order_price 10000(normal)
# - [x] order_price 10001(bronze)
# - [x] order_price 30000(bronze)
# - [x] order_price 30001(silver)
# - [x] order_price 70000(silver)
# - [ ] order_price 70001(gold)
# - [ ] order_price 100000(gold)
# - [ ] order_price 100001(pratinum)
RSpec.describe Mogec::UserRankUpdater do
  describe "#run" do
    let(:user) { FactoryBot.create(:user, :purchased, price: price) }

    before do
      Mogec::UserRankUpdater.new(user: user.id).run
    end

    context "when user purchased 0 yen" do
      let(:user) { FactoryBot.create(:user) }

      it "user's rank should be normal" do
        expect(user.reload.rank).to eq "normal"
      end
    end

    context "when user purchased 10000 yen" do
      let(:price) { 10000 }

      it "user's rank should be normal" do
        expect(user.reload.rank).to eq "normal"
      end
    end

    context "when user purchased 10001 yen" do
      let(:price) { 10001 }

      it "user's rank should be bronze" do
        expect(user.reload.rank).to eq "bronze"
      end
    end

    context "when user purchased 30000 yen" do
      let(:price) { 30000 }

      it "user's rank should be bronze" do
        expect(user.reload.rank).to eq "bronze"
      end
    end

    context "when user purchased 30001 yen" do
      let(:price) { 30001 }

      it "user's rank should be silver" do
        expect(user.reload.rank).to eq "silver"
      end
    end

    context "when user purchased 70000 yen" do
      let(:price) { 70000 }

      it "user's rank should be silver" do
        expect(user.reload.rank).to eq "silver"
      end
    end
  end
end
