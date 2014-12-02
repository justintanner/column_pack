module ColumnPack

  # Arranges HTML elements into a fixed number of columns.
  class ColumnPacker
    include ActionView::Context
    include ActionView::Helpers

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

    # Adds element to be packed.
    def add(height, content = nil, &block)
      if block_given?
        @bin_packer.add(height.to_i, capture(&block))
      else
        @bin_packer.add(height.to_i, content)
      end
    end

    # Renders all elements into columns.
    def render
      render_columns(@bin_packer.bins)
    end

    private
    def render_columns(bins)
      content_tag :div, :class => "column-pack-wrap" do
        capture do
          bins.each do |bin|
            concat render_single_column(bin)
          end
        end
      end
    end

    def render_single_column(bin)
      content_tag :div, :class => "column-pack-col" do
        capture do
          bin.each do |element|
            concat render_element(element)
          end
        end
      end
    end

    def render_element(element)
      content_tag :div, element, :class => "column-pack-element"
    end
  end
end
