ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'rake'
require 'elasticsearch/extensions/test/cluster/tasks'



RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before :each, elasticsearch: true do
    Elasticsearch::Extensions::Test::Cluster.start(port: 9200) unless Elasticsearch::Extensions::Test::Cluster.running?
  end

  config.after :suite do
    Elasticsearch::Extensions::Test::Cluster.stop(port: 9200) if Elasticsearch::Extensions::Test::Cluster.running?
  end

end
