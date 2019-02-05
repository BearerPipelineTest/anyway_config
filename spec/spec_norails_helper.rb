# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

begin
  require "pry-byebug"
rescue LoadError
end

require "anyway_config"

Anyway::Settings.use_local_files = false

require "erb"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed

  config.after(:each) do
    Anyway.env.clear
    ENV.delete_if { |var| var =~ /^(cool_|any)/i }
  end
end
