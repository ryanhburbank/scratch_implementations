
require "fiber"

module ScratchEnumerable
	
	def initialize(object,method)
		@object = object
		@method = method
	end

	def my_map
		if block_given?
			[].tap {|out| self.each {|e| out << yield(e) }}
		else
			ScratchEnumerator.new(self, :my_map)
		end
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
			return self.my_reduce {|s,e| s.send(operation_or_value, e)} 
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

class ScratchEnumerator
	include ScratchEnumerable
	attr_reader :target, :iteration

	def initialize(target, iteration)
		@target = target
		@iteration = iteration
	end

	def each(&block)
		@target.send(@iteration, &block)
	end

	def with_index
		i = 0
		each do |e|
			out = yield(e,i)
			i += 1
			out
		end
	end

	def rewind
		@fiber = nil
	end

	def next
		#when initially called returns the first iteration's yield
		#after, when #resume called, goes back to the block
		# when called again,if fiber #alive?, (i.e block has iterations remaining)
		#returns next second iteration's yield
		#after iterations complete, if called, raises StopIteration
		@fiber ||= Fiber.new do
			each { |e| Fiber.yield(e) }

			raise StopIteration
		end
		if @fiber.alive?
			 @fiber.resume
		else
			raise StopIteration
		end 
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
