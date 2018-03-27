require "rails_helper"
require "mogec/userrank_updater"

RSpec.describe Mogec::UserRankUpdater do
  describe "#run" do
    context "When user purchased 10001 yen" do
      it "user's rank should be bronze" do
        user = FactoryBot.create(:user_10001)
        options = { user: user.id }
        userrank_updater = Mogec::UserRankUpdater.new(options)
        userrank_updater.run

        expect(user.reload.rank).to eq "bronze"
      end
    end
  end
end
