require 'test/unit'
require 'rubygems'
require 'action_controller'
require 'action_controller/test_case'
require 'action_controller/test_process'


class ApplicationController < ActionController::Base
end

require File.dirname(__FILE__) + '/../app/controllers/publicious_controller'
