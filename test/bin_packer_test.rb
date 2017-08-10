require 'test_helper'

class BinPackerTest < ActiveSupport::TestCase
  include ColumnPack

  test "initilizes with three columns" do
    bp = BinPacker.new(3)
    assert_equal BinPacker, bp.class
    assert_equal Array, bp.bins.class
  end

  test "can't init with a non-positive number of cols" do
    assert_raises ArgumentError do
      BinPacker.new(0)
    end

    assert_raises ArgumentError do
      BinPacker.new(-100)
    end
  end

  test "adds element" do
    bp = BinPacker.new(1)
    assert bp.add(400, 'A')
    assert_equal 'A', bp.bins[0][0]
  end

  test "height must be greater than zero" do
    bp = BinPacker.new(3)
    assert_raises ArgumentError do
      bp.add(0, 'A')
    end

    assert_raises ArgumentError do
      bp.add(-1, 'A')
    end
  end

  test "adds two elements" do
    bp = BinPacker.new(2, {:algorithm => :best_fit_decreasing})
    assert bp.add(400, 'A')
    assert bp.add(500, 'B')

    assert_equal 'A', bp.bins[1][0]
    assert_equal 'B', bp.bins[0][0]
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

  test "test different packing algorithms" do
    bp = BinPacker.new(3, {:algorithm => :best_fit_decreasing})
    bp.add(100, 'A')
    bp.add(900, 'B')
  end

  test "can turn off shuffling" do
    bp = BinPacker.new(1, {:algorithm => :best_fit_decreasing, :shuffle_in_col => false})
    bp.add(900, 'A')
    bp.add(800, 'B')
    bp.add(700, 'C')
    bp.add(600, 'D')
    bp.add(500, 'E')
    bp.add(400, 'F')

    assert_equal 'A', bp.bins[0][0]
    assert_equal 'B', bp.bins[0][1]
    assert_equal 'C', bp.bins[0][2]
    assert_equal 'D', bp.bins[0][3]
    assert_equal 'E', bp.bins[0][4]
    assert_equal 'F', bp.bins[0][5]
  end

  test "big data set" do
    (2..10).each do |num_bins|
      assert bp = BinPacker.new(num_bins)

      File.readlines(File.expand_path('test/fixtures/files/hundred.txt')).each do |line|
        number, name, = line.split(' ')
        assert bp.add(number.to_i, name)
      end
    end
  end

  test "six items with a perfect fit" do
    bp = BinPacker.new(3)
    bp.add(100, 'A')
    bp.add(300, 'B')
    bp.add(50, 'C')
    bp.add(350, 'D')
    bp.add(200, 'E')
    bp.add(200, 'F')

    assert_equal 0, bp.empty_space
  end

end
