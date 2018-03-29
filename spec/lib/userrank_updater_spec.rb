require "rails_helper"
require "mogec/userrank_updater"

RSpec.describe Mogec::UserRankUpdater do
  describe "#run" do
    shared_examples "user rank is not changed" do
      it "should not change user rank" do
        expect {
          Mogec::UserRankUpdater.new(user: user.id).run
        }.to_not change { user.reload.rank }
      end
    end

    shared_examples "user rank is changed according to purchase price" do
      it "should change user rank" do
        expect {
          Mogec::UserRankUpdater.new(user: user.id).run
        }.to change { user.reload.rank }.from("normal").to(rank)
      end
    end

    context "when user purchased 30000 yen 13 months ago" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 30000, ordered_at: 13.months.ago) }
      include_examples "user rank is not changed"
    end

    context "when user purchased 30000 yen this month" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 30000, ordered_at: Time.zone.now) }
      include_examples "user rank is not changed"
    end

    context "when user purchased 0 yen" do
      let(:user) { FactoryBot.create(:user) }
      include_examples "user rank is not changed"
    end

    context "when user purchased 10000 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 10000) }
      include_examples "user rank is not changed"
    end

    context "when user purchased 10001 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 10001) }
      let(:rank) { "bronze" }
      include_examples "user rank is changed according to purchase price"
    end

    context "when user purchased 30000 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 30000) }
      let(:rank) { "bronze" }
      include_examples "user rank is changed according to purchase price"
    end

    context "when user purchased 30001 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 30001) }
      let(:rank) { "silver" }
      include_examples "user rank is changed according to purchase price"
    end

    context "when user purchased 70000 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 70000) }
      let(:rank) { "silver" }
      include_examples "user rank is changed according to purchase price"
    end

    context "when user purchased 70001 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 70001) }
      let(:rank) { "gold" }
      include_examples "user rank is changed according to purchase price"
    end

    context "when user purchased 100000 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 100000) }
      let(:rank) { "gold" }
      include_examples "user rank is changed according to purchase price"
    end

    context "when user purchased 100001 yen" do
      let(:user) { FactoryBot.create(:user, :purchased, price: 100001) }
      let(:rank) { "pratinum" }
      include_examples "user rank is changed according to purchase price"
    end
  end
end
