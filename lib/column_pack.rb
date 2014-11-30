require 'column_pack/railtie' if defined? Rails

module ColumnPack
  module Rails
    class Engine < ::Rails::Engine
      # Get rails to add app, lib, vendor to load path
    end
  end
end
