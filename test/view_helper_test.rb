require 'test_helper'

require 'erubis'

class ViewHelperTest < ActiveSupport::TestCase
  include ColumnPack::ViewHelpers

  include ActionView::Context
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper

  test "pack_elment does nothing on it's own" do
    assert_nothing_raised do
      pack_element(100, 'A')
      pack_element(100) do
        link_to "http://www.google.com", content_tag(:p, "ZAP")
      end
    end
  end

  test "pack text into columns" do
    html = pack_in_columns(3) do
      (1..10).each do |number|
        pack_element(number) do
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
    html = pack_in_columns(3) do
      pack_element(100) do
        link_to "http://www.google.com", content_tag(:p, "ZAP") + "a string"
      end
    end
    assert_includes html, "ZAP"
  end
end
