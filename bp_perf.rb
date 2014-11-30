require_relative 'lib/column_pack/bin_packer'

include ColumnPack

hundred = File.readlines(File.expand_path('./test/dummy/test/fixtures/files/hundred.txt'))

bp_inc = BinPacker.new(5, :best_fit_increasing)
bp_dec = BinPacker.new(5, :best_fit_decreasing)

algos = [:best_fit_increasing, :best_fit_decreasing]


algos.each do |algo|
  empty_spaces = []

  (2..20).each do |num_bins|

    bp = BinPacker.new(num_bins, algo)
    hundred.each do |line|
      number, name, = line.split(' ')
      bp.add(number.to_i, name)
    end

    empty_spaces << bp.empty_space
  end

  puts "#{algo.to_s} average empty space: " + (empty_spaces.reduce(:+).to_f / empty_spaces.size).to_i.to_s
  puts "#{algo.to_s} max empty space: " + empty_spaces.max.to_s
  puts "#{algo.to_s} min empty space: " + empty_spaces.min.to_s
end
