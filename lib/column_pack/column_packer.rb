module ColumnPack
  # Arranges HTML elements into a fixed number of columns.
  class ColumnPacker
    include ActionView::Context
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper

    # Uses a fixed number of columns (total_columns).
    #
    # Options:
    # :algorithm        specify a different bin packing algorithm (default :best_fit_decreasing)
    #                   available algorithms are :best_fit_decreasing, :best_fit_increasing
    #
    # :shuffle_in_col   after packing columns, shuffle the elements in each column (defaults to true)
    #
    def initialize(total_columns, options = {})
      @bin_packer = BinPacker.new(total_columns, options)
    end

    def add(height, content)
      @bin_packer.add(height.to_i, content)
    end

    # Renders all elements into columns.
    def render
      wrap(@bin_packer.bins).html_safe
    end

    private
    def wrap(bins)
      content_tag :div, :class => "column-pack-wrap" do
        capture do
          bins.each do |bin|
            concat column(bin)
          end
        end
      end
    end

    def column(bin)
      content_tag :div, :class => "column-pack-col" do
        capture do
          bin.each do |element|
            concat element(element)
          end
        end
      end
    end

    def element(element)
      content_tag :div, element.html_safe, :class => "column-pack-element"
    end
  end
end
