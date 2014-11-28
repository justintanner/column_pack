require 'rubygems'
require 'minitest/autorun'
require 'active_support'
require 'active_support/core_ext'
require 'action_view'
require 'action_controller'
require 'action_controller/test_case'

require 'column_pack'

class ActiveSupport::TestCase
  def fixture_path
    File.expand_path("../fixtures", __FILE__)
  end
end
