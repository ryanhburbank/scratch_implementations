#need functions to
# 1: put entry at top of list
# 2: put entry at bottom of list
# 3: put remove entry from top of list
# This will make manipulating the list significantly
# easier

#code for list entry
class Entry
	attr_accessor :next, :data

	def initialize(data)
		@next = nil
		@data = data
	end
end

#next var is a pointer to the following entry in list
#data var holds data within each entry

#the list itself
class List
	attr_accessor :name #track list's name(if any)

	def initialize
		@head = nil
		@tail = nil
		#note head & tail are not exposed
	end

	def head_insert(entry) #puts entry on top of queue
		if @head.nil?
			@head = entry
			@tail = entry
		else
			entry.next = @head
			@head = entry
		end
		return self
	end

	def tail_insert(entry) #puts entry on bottom of queue
		if @head.nil?
			@head = entry
			@tail = entry
		else
			@tail.next = entry
			@tail = entry
		end
		return self
	end

	def remove_head #return and return head of list
		return nil if @head.nil?
		entry = @head
		@head = @head.next
		return entry
	end

	def reverse!
		return if @head.nil?

		tmp_head = self.remove_head
		tmp_head.next = nil
		@tail = @tmp_head

		until @head.nil?
			entry = self.remove_head
			entry.next = tmp_head
			tmp_head = entry
		end

		@head = tmp_head
		return self
	end
	
	def each
		return nil if @head.nil?
		entry = @head
		until entry.nil?
			yield entry
			entry = entry.next
		end
	end

	def reverse
		new_list = List.new
		self.each {|entry| new_list.head_insert(Entry.new(entry.data)) }
		return new_list
	end
end

def bench(structure, iterations)
	start = Time.now
	yield 
	finish = Time.now
	puts "#{structure} took #{finish - start} to complete #{iterations} insertions"
end

array = Array.new
bench("array",100000) {
	100000.times { |i| array.insert(0,i) }
}

list = List.new
bench("linked list", 100000) {
	100000.times { |i| list.head_insert(Entry.new(i)) }
}

