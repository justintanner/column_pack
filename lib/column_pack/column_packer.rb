module ColumnPack
  class ColumnPacker
    include ActionView::Helpers::TagHelper
    include ActionView::Context

    def initialize(total_bins, options = nil)
      @bin_packer  = BinPacker.new(total_bins, options)
    end

    def add(height, content = nil, &block)
      if content.nil?
        @bin_packer.add(height.to_i, capture(&block))
      else
        @bin_packer.add(height.to_i, content)
      end
    end

    def render
      render_columns(@bin_packer.bins)
    end

    private
    def render_columns(bins)
      content_tag :div, :class => "column-pack-wrap" do
        bins.collect { |bin| render_single_column(bin) }.join("\n").html_safe
      end
    end

    def render_single_column(bin)
      content_tag :div, :class => "column-pack-col" do
        bin.collect { |element| render_element(element) }.join("\n").html_safe
      end
    end

    def render_element(element)
      content_tag :div, element, :class => "column-pack-element"
    end
  end
end
