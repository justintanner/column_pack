require 'test_helper'

class ColumnPackerTest < ActiveSupport::TestCase
  include ColumnPack

  test "initilizes with three columns" do
    cp = ColumnPacker.new(3)
    assert_equal ColumnPacker, cp.class
  end

  test "accepts blocks" do
    cp = ColumnPacker.new(3)

    cp.add(100) do
      "ZAP"
    end

    assert_includes cp.render, 'ZAP'
  end

  test "accepts non-blocks" do
    cp = ColumnPacker.new(3)
    cp.add(100, 'ZAP')
    assert_includes cp.render, 'ZAP'
  end

  test "padds block" do
    cp = ColumnPacker.new(3, {:algorithm => :best_fit_increasing, :pad_to_fit => true})
    cp.add(100, 'A')
    cp.add(100, 'B')
    cp.add(100, 'C')
    cp.add(299, 'D')
    assert_includes cp.render, "margin-bottom: 299px"
  end

end
