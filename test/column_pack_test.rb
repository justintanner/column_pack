require 'test_helper'

class ColumnPackTest < ActiveSupport::TestCase
  include ColumnPack::ViewHelpers

  test "pack_in_columns" do
    html = pack_in_columns(3) do |elements|
      (1..10).each do |number|
        elements.add(number) do
          "UNIQUE#{number}"
        end
      end
    end
    assert_equal ActiveSupport::SafeBuffer, html.class

    (1..10).each do |number|
      assert_includes html, "UNIQUE#{number}"
    end
  end
end
