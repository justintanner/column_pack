module ColumnPack
  class ColumnPacker
    include ActionView::Helpers::TagHelper
    include ActionView::Context

    def initialize(total_bins, options = nil)
      options ||= {}
      @bin_packer = BinPacker.new(total_bins, options)
      @pad_to_fit = options[:pad_to_fit] || false
      @padding    = Array.new(total_bins, 0) if @pad_to_fit
    end

    def add(height, content = nil, &block)
      if content.nil?
        @bin_packer.add(height.to_i, capture(&block))
      else
        @bin_packer.add(height.to_i, content)
      end
    end

    def render
      calculate_padding if @pad_to_fit
      render_columns(@bin_packer.bins)
    end

    private
    def render_columns(bins)
      content_tag :div, :class => "column-pack-wrap" do
        bins.enum_for(:each_with_index).collect { |bin, bin_index| render_single_column(bin, bin_index) }.join("\n").html_safe
        #cols.collect { |col| render_single_column(col) }.join("\n").html_safe
      end
    end

    def render_single_column(bin, bin_index)
      content_tag :div, :class => "column-pack-col" do
        bin.collect { |element| render_element(element, bin_index) }.join("\n").html_safe
      end
    end

    def render_element(element, bin_index)
      style = "margin-bottom: #{@padding[bin_index]}px" if @pad_to_fit
      content_tag :div, element, :class => "column-pack-element", :style => style
    end

    def calculate_padding
      max_height = @bin_packer.sizes.max

      @bin_packer.sizes.each_with_index do |col_height, index|
        @padding[index] = (max_height - col_height) / @bin_packer.bins[index].length
      end
    end
  end
end
