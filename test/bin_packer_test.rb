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

  test "size is correct" do
    bp = BinPacker.new(3, {:algorithm => :best_fit_decreasing})
    bp.add(200, 'A')
    bp.add(900, 'B')
    assert_equal 900, bp.sizes[0]
    assert_equal 200, bp.sizes[1]
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

  test "six items with a perfect fit" do
    bp = BinPacker.new(3)
    bp.add(100, 'A')
    bp.add(300, 'B')
    bp.add(50, 'C')
    bp.add(350, 'D')
    bp.add(200, 'E')
    bp.add(200, 'F')

    assert_equal 0, bp.empty_space
    assert_equ
  end


end
