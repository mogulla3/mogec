module Mogec
  class UserRankUpdater
    attr_reader :dryrun, :user, :log

    def initialize(opt = {})
      @dryrun = opt.fetch(:dryrun, false)
      @user = opt.fetch(:user, [])
      @user_file = opt.fetch(:file, nil)
      @log = Logger.new(opt[:log] || STDOUT)
    end

    def run
      Signal.trap(:INT) do
        unless @dryrun
          unprocessed_users = @target_users - @completed_users
          File.write("./unprocessed_users.txt", unprocessed_users.join("\n"))
          puts "aborted because SIGINT is called. And wrote unprocessed user's id to ./unprocessed_users.txt"
        end

        exit 1
      end

      # 対象ユーザの決定
      # 1. userオプション
      # 2. fileオプション
      # 3. 全user
      @target_users = if @user.present?
                        @user
                      elsif @user_file
                        File.read(@user_file).split("\n")
                      else
                        User.pluck(:id)
                      end

      @completed_users = []
      @target_users.each do |user_id|
        # (先月末から1年前) ~ (先月末)
        # from: A year ago from the end of last month
        # to: end of last month
        #
        # Example
        # now: 2018-03-25 10:00:00
        # from => 2017-03-01 00:00:00
        # to => 2018-02-28 23:59:59
        basetime = Time.zone.now.beginning_of_month
        from = basetime - 1.year
        to = basetime - 1.seconds

        items = Order.where(user_id: user_id, ordered_at: from..to).pluck(:item_id)
        total_price = Item.where(id: items).sum(:price)

        rank = case total_price
               when 0..10000 then "normal"
               when 10001..30000 then "bronze"
               when 30001..70000 then "silver"
               when 70001..100000 then "gold"
               when 100001..Float::INFINITY then "pratinum"
               end

        user = User.find_by(id: user_id)

        # FIXME: duplicated code
        if @dryrun
          @log.info("[dryrun] Updated rank of #{user.name}(id:#{user.id}) from '#{user.rank}' to '#{rank}'. purchased price => #{total_price}")
        else
          @log.info("Updated rank of #{user.name}(id:#{user.id}) from '#{user.rank}' to '#{rank}'. purchased price => #{total_price}")
          user.update(rank: rank)
        end

        @completed_users << user_id
      end
    end
  end
end
