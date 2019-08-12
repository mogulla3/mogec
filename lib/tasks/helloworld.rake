# frozen_string_literal: true

namespace :helloworld do
  desc 'Hello world task for running on Amazon ECS'
  task test: :environment do
    puts 'Hello world! by puts'
    Rails.logger.info('Hello world! by rails logger')

    puts Item.name
  end
end
