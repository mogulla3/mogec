require "optparse"
require "mogec/userrank_updater"

module Mogec
  class Command
    def initialize(args)
      @options = {}

      opt = OptionParser.new

      opt.on("-n", "--dryrun", "only output the command result and don't udpate") do
        @options[:dryrun] = true
      end

      opt.on("-u", "--user=USER", "target users specified comma separeted") do |v|
        @options[:user] = v.split(",")
      end

      opt.on("-o", "--log=PATH", "log file path") do |v|
        @options[:log] = v
      end

      opt.on("-h", "--help", "Show this message") do
        puts opt
        exit 1
      end

      opt.parse!(args)
    end

    def start
      Mogec::UserRankUpdater.new(@options).run
    end
  end
end