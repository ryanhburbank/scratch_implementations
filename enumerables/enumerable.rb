
module ScratchEnumerable
	
	def initialize(object,method)
		@object = object
		@method = method
	end

	def my_map
		[].tap {|out| self.each {|e| out << yield(e) }}
	end

	def my_map!
		self.each {|e| e = yield(e)}
		self
	end

	def my_select
		[].tap {|out| self.each {|e| out << e if yield(e)}}
	end

	def my_sort_by
		self.my_map {|a| [yield(a), a]}.sort.my_map {|a| a[1]}
	end

	def my_reduce(operation_or_value = nil)
		case operation_or_value
		when Symbol
			return self.reduce {|s,e| s.send(operation_or_value, e)} 
		when nil
			accumulator_value = nil
		else
			accumulator_value = operation_or_value
		end

		self.each do |a|
			if accumulator_value.nil?
				accumulator_value = a
			else
				accumulator_value = yield(accumulator_value, a)
			end
		end

		return accumulator_value
	end

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
			return @elements
		else
			return ScratchEnumerator.new(self,:each)
		end
	end

	def to_s
		@elements
	end
end
