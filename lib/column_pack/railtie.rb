require 'column_pack/view_helpers'
require 'column_pack/bin_packer'
require 'column_pack/column_packer'

module ColumnPack
  class Railtie < Rails::Railtie
    initializer "column_pack.view_helpers" do |app|
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
