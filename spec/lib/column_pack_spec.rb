require 'spec_helper'

describe ColumnPack do
  it "should initalize" do
    column_pack = ColumnPack.new(3)
    expect(column_pack.class).to eq ColumnPack
  end
end
