require 'rspec'

begin
  require 'pry'
  require 'pry-doc'
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
rescue LoadError
end

require 'peddler'
