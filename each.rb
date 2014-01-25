class Array
	def my_each
		length = self.length
		length.times {|e| yield(self[e]) }
	end
end

[1,2,3].my_each {|i| puts i + 1 }