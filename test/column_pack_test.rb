require 'test_helper'

class ColumnPackTest < ActiveSupport::TestCase

  test "truth" do
    assert_kind_of Module, ColumnPack
  end

  test "pack_in_columns" do
    pack_in_columns(3) do |elements|
      (1..10).each do |number|
        elements.add(number) do
          "something"
        end
      end
    end
  end
end
