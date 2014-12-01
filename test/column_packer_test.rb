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

  test "test shuffling in columns" do
    no_shuffle = ColumnPacker.new(3, {:shuffle_in_col => false})
    no_shuffle.add(100, 'A')
    no_shuffle.add(200, 'B')
    no_shuffle.add(300, 'C')
    no_shuffle.add(400, 'D')
    no_shuffle.add(500, 'E')
    no_shuffle.add(600, 'F')

    shuffle = ColumnPacker.new(3, {:shuffle_in_col => true})
    shuffle.add(100, 'A')
    shuffle.add(200, 'B')
    shuffle.add(300, 'C')
    shuffle.add(400, 'D')
    shuffle.add(500, 'E')
    shuffle.add(600, 'F')

    assert_not_equal no_shuffle.render, shuffle.render
  end

end
