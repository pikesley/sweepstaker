# Generated by cucumber-sinatra. (2014-05-21 16:03:43 +0100)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/stake_sweeper.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = StakeSweeper

class StakeSweeperWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  StakeSweeperWorld.new
end
