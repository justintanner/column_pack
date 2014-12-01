require 'test_helper'

class ViewHelperTest < ActiveSupport::TestCase
  include ColumnPack::ViewHelpers
  include ActionView::Helpers::UrlHelper

  test "pack text into columns" do
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

  test "pack html into columns" do
    html = pack_in_columns(3) do |elements|
      elements.add(100) do
        link_to "http://www.google.com", "ZAP"
      end
    end
    assert_includes html, "ZAP"
  end

end
