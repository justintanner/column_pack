require 'test_helper'

class BinPackerTest < ActiveSupport::TestCase
  include ColumnPack

  test "initilizes with three columns" do
    bp = BinPacker.new(3)
    assert_equal BinPacker, bp.class
    assert_equal Array, bp.bins.class
  end

  test "adds element" do
    bp = BinPacker.new(1)
    assert bp.add(400, 'A')
    assert_equal 'A', bp.bins[0][0]
  end

  test "adds two elements" do
    bp = BinPacker.new(2)
    assert bp.add(400, 'A')
    assert_equal 'A', bp.bins[0][0]
    assert bp.add(500, 'B')
    assert_equal 'B', bp.bins[1][0]
  end

  test "add accepts blocks" do
    bp = BinPacker.new(3)

    bp.add(400) do
      "A"
    end

    assert_equal 'A', bp.bins[0][0]

    bp.add(500) do
      "B"
    end

    assert_equal 'B', bp.bins[1][0]
  end

  test "add six elements" do
    bp = BinPacker.new(3)
    bp.add(600, 'F')
    bp.add(300, 'C')
    bp.add(500, 'E')
    bp.add(400, 'D')
    bp.add(200, 'B')
    bp.add(100, 'A')
    assert_equal 3, bp.bins.length

    assert_equal Array, bp.bins[0].class
    assert_operator 1, :<, bp.bins[0].length

    assert_equal Array, bp.bins[1].class
    assert_operator 1, :<, bp.bins[1].length

    assert_equal Array, bp.bins[2].class
    assert_operator 1, :<, bp.bins[2].length
  end

  test "can iterate bins" do
    bp = BinPacker.new(3)
    bp.add(600, 'F')
    bp.add(300, 'C')
    bp.add(500, 'E')
    bp.add(400, 'D')
    bp.add(200, 'B')
    bp.add(100, 'A')

    assert_equal Array, bp.bins.class

    bp.bins.each do |bin|
      bin.each do |element|
        assert_includes ['A', 'B', 'C', 'D', 'E', 'F'], element.to_s
      end
    end
  end

  test "empty space" do
    bp = BinPacker.new(3)
    bp.add(200, 'A')
    bp.add(900, 'B')
    assert_equal 1600, bp.empty_space
  end

  test "big data set" do

    (2..10).each do |num_bins|
      assert bp = BinPacker.new(num_bins)

      File.readlines(fixture_path + 'files/hundred.txt').each do |line|
        number, name, = line.split(' ')
        assert bp.add(number.to_i, name)
      end
      assert_operator 0, :<, bp.empty_space
    end

  end

end
