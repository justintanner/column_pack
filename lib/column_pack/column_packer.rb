module ColumnPack
  class ColumnPacker
    include ActionView::Helpers::TagHelper
    include ActionView::Context

    def initialize(total_bins, options = nil)
      options ||= {}
      @bin_packer  = BinPacker.new(total_bins, options)

      # need 6 items to fit
      @pad_to_fit  = options[:pad_to_fit] || false
      @min_padding = options[:min_padding] || 5
      @padding     = Array.new(total_bins, 0) if @pad_to_fit
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
        bin.enum_for(:each_with_index).collect { |el, el_index| render_element(bin, bin_index, el, el_index) }.join("\n").html_safe
      end
    end

    def render_element(bin, bin_index, element, element_index)
      if @pad_to_fit
        if element_index >= (bin.length - 1)
          padding = 0
        else
          padding = @padding[bin_index]
        end
        padding = @min_padding if @padding == 0
        style = "margin-bottom: #{padding}px"
      end
      content_tag :div, element, :class => "column-pack-element", :style => style
    end

    def calculate_padding
      max_height = @bin_packer.sizes.max

      @bin_packer.sizes.each_with_index do |col_height, index|
        num_of_elements = @bin_packer.bins[index].length

        if num_of_elements < 2
          @padding[index] = 0
        else
          @padding[index] = (max_height - col_height) / (num_of_elements - 1)
        end
      end
    end
  end
end
