require 'rspec'
require 'prime'

require 'simplecov'
SimpleCov.start

require_relative '../lib/cli.rb'
require_relative '../lib/multiplication_table.rb'
require_relative '../lib/prime_number.rb'
require_relative '../lib/table_printer.rb'

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.new(File.join(__dir__, 'dev', 'null.txt'), 'w')
    $stdout = File.new(File.join(__dir__, 'dev', 'null.txt'), 'w')
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end