
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
