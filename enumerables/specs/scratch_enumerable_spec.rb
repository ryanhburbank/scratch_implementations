require "minitest/autorun"
require_relative '../emumerable'

describe "ScratchEnumerable" do
	let(:array){ [1,2,3] }
	let(:hash) { [foo: 1, oof: 2] }
	let(:list) { SortedList.new([5,4,1])}

	describe "instance methods" do
		it "supports map" do
			@list.my_map { |e| e * e }.must_equal([25,16,36])
		end

		it "support select" do
			skip
			@list.my_select { |e| e.even? }.must_equal([4,6])
		end

		it "support sort_by" do
			skip
			@list.my_sort_by {|e| x.to_s }.must_equal([4,5,6])
		end

		it "supports reduce" do
			skip
			@list.my_reduce(:+).must_equal(69)
			@list.my_reduce {|s,e| s + e }.must_equal(69)
			@list.my_reduce(-10) {|s,e| s + e }.must_equal(59)
		end
	end
end