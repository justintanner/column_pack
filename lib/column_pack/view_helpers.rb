
module ColumnPack
  module ViewHelpers

    include ActionView::Helpers::TagHelper
    include ActionView::Context

    def pack_in_columns(total_columns, algorithm = :best_fit_increasing, shuffle_in_col=true)
      bp = BinPacker.new(total_columns, algorithm, shuffle_in_col)

      yield(bp)

      render_columns(bp.bins)
    end

    private
    def render_columns(cols)
      content_tag :div, :class => "column-pack-wrap" do
        cols.collect { |col| render_single_column(col) }.join("").html_safe
      end
    end

    def render_single_column(col)
      content_tag :div, :class => "column-pack-col" do
        col.each.collect { |row| row.to_s }.join("").html_safe
      end
    end

  end
end
