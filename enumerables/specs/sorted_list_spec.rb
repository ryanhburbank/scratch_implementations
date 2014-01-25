require "minitest/autorun"
require_relative '../emumerable'

describe "SortedList" do
	let(:list) { SortedList.new([5,4,1]) }

	it "#<< adds to the list and then sorts the list" do
		list.elements.must_equal([1,4,5])
	end

	it "#each iterates without destructively changing values" do
		test = 0
		list.each {|e| test += e }.must_equal([1,4,5])
		test.must_equal(10)
	end
end