require "minitest/autorun"

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

module ScratchEnumerable
	
	def initialize(object,method)
		@object = object
		@method = method
	end

	def my_map
		output = []
		each {|e| output << yield(e) }
		output 
	end

	# def my_select
		# if block_given?
		# 	self.each {|e| yield if e }
		# else
		# 	self
		# end	
	# end

	# def my_sort_by
	# end

	# def my_reduce(*args)
	# end

	def to_s
		"#<#{self.class} #{@object}:#{@method}>"
	end
end

class Array
	include ScratchEnumerable
end

class Hash
	include ScratchEnumerable
end

class SortedList
	include ScratchEnumerable
	attr_reader :elements
	
	def initialize(values = nil)
		@elements = []
		values.each {|e| self<< e } if values.class == Array
		self<<(values) if values.class == Fixnum
	end

	def <<(added_element)
		@elements << added_element
		@elements.sort!

		self
	end

	def each 
		if block_given?
			@elements.length.times { |index| yield(@elements[index]) }
			@elements
		else
			self
		end
	end

	def to_s
		@elements
	end
end
