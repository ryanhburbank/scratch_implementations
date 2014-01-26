require "minitest/autorun"
require_relative '../enumerable'

describe "ScratchEnumerable" do
	let(:array){ [1,2,3] }
	let(:hash) { [foo: 1, oof: 2] }
	let(:list) { SortedList.new([-5,4,1])}

	describe "instance methods" do
		it "supports map" do
			list.my_map { |e| e * e }.must_equal([25,1,16])
		end

		it "support select" do
			list.my_select { |e| e.even? }.must_equal([4])
		end

		it "support sort_by" do
			list.my_sort_by {|e| e.abs }.must_equal([1,4,-5])
		end

		it "supports reduce" do
			list.my_reduce(:+).must_equal(0)
			list.my_reduce {|s,e| s + e }.must_equal(0)
			list.my_reduce(-10) {|s,e| s + e }.must_equal(-10)
		end
	end
end

describe "ScratchEnumerator" do 
		let(:list) { SortedList.new([1,4,5])}

		it "supports each" do
			enumerator = list.each
			test = 0
			enumerator.each {|i| test += i }
			test.must_equal(10)
		end

		it "supports next" do
			enum = list.each

			enum.next.must_equal(1)
			enum.next.must_equal(4)
			enum.next.must_equal(5)

			assert_raises(StopIteration) { enum.next }
		end

		it "supports rewind" do
			enum = list.each
			enum.next
			enum.next
			enum.next
			assert_raises(StopIteration) { enum.next }
			enum.rewind
			enum.next.must_equal(1)
		end

		it "supports with_index" do
			enum = list.my_map
			expected = ["0: 1","1: 4","2: 5"]

			enum.with_index {|e,i| "#{i}: #{e}"}.must_equal(expected)
		end
end