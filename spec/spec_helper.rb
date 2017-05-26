require 'bundler/setup'
require 'active_record'
require 'tokenable'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :token
  end
end

class User < ActiveRecord::Base
  tokenable.config do |c|
    c.attrs  = :token
    c.n      = 20..42
    c.meth0d = :urlsafe_base64
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
