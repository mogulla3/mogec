module Mogec
  class UserRankUpdater
    attr_reader :dryrun, :user, :log

    def initialize(opt = {})
      @dryrun = opt.fetch(:dryrun, false)
      @user = Array(opt.fetch(:user))
      @log = opt.fetch(:log, nil)
    end

    def run
      @user.each do |user_id|
        # (先月末から1年前) ~ (先月末)
        # from: A year ago from the end of last month
        # to: end of last month
        #
        # Example
        # now:    2018-03-25 10:00:00
        # before: 2017-03-01 00:00:00
        # to:     2018-02-28 23:59:59
        basetime = Time.zone.now.beginning_of_month
        from = basetime - 1.year
        to = basetime - 1.seconds

        items = Order.where(user_id: user_id, ordered_at: from..to).pluck(:item_id)
        total_price = Item.where(id: items).sum(:price)

        rank = case total_price
               when 10001..30000
                 "bronze"
               else
                 "normal"
               end

        user = User.find_by(id: user_id)
        user.update(rank: rank)
      end
    end
  end
end
