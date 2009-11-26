require 'rubygems'
require 'yaml'
require 'mustache'

module Smeg; end

Dir["#{File.dirname(__FILE__)}/smeg/*.rb"].each {|f| require f }