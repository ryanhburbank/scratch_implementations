require "minitest/autorun"

class Array
	def my_each
		if block_given?
			length = self.length
			length.times {|e| yield(self[e]) }
		else
			ScratchEnumerator.new(self, :each)
		end
	end
end

class ScratchEnumerator
	def initialize(instance, method)
		@instance = instance
		@method = method
	end

	def to_s
		"#<ScratchEnumerator: #{@instance}:#{@method}"
	end
end
puts [1,2,3].my_each

describe "Array" do
	let(:array) { [1,2,3] }

	describe "my_each" do
		it "iterates over each element of the array" do
			sum = 0
			array.my_each {|i| sum += i }
			sum.must_equal(6) 
		end

		it "returns a ScratchEnumerator when no block is given" do
			array.my_each.class.must_equal ScratchEnumerator 
		end
	end
end