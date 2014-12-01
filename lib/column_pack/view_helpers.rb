module ColumnPack
  module ViewHelpers

    def pack_in_columns(total_columns, options = {})
      cp = ColumnPacker.new(total_columns, options)

      yield(cp)

      cp.render
    end

  end
end
