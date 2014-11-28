module ColumnPack
  module ViewHelpers

    def pack_in_columns(total_columns, algorithm = :best_fit_increasing)
      bp = BinPacker.new(total_columns, algorithm)

      yeild(bp)

      bp.each do |col|
        col.each do |row|
          puts row.to_s
        end
      end
    end

  end
end
