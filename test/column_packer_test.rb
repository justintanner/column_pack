require 'test_helper'

class ColumnPackerTest < ActiveSupport::TestCase
  include ColumnPack

  test "initilizes with three columns" do
    cp = ColumnPacker.new(3)
    assert_equal ColumnPacker, cp.class
  end

  test "add an element" do
    cp = ColumnPacker.new(3)
    cp.add(100, 'ZAP')
    assert_includes cp.render, 'ZAP'
  end
end
