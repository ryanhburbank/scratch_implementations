
class Entry
	attr_accessor :next, :data

	def initialize(data)
		@next = nil
		@data = data
	end

	def to_s
		"@data=#{@data} @next={#{@next || 'nil'}}"
	end
end


class List
	attr_accessor :name #track list's name(if any)
	attr_reader :head, :tail
	def initialize(name = nil)
		@head = nil
		@tail = nil
		@name = name
	end

	def head_insert(entry) #puts entry on top of queue
		if @head.nil?
			@head = entry
			@tail = entry
		else
			entry.next = @head
			@head = entry
		end
		self
	end

	def tail_insert(entry) #puts entry on bottom of queue
		if @head.nil?
			@head = entry
			@tail = entry
		else
			@tail.next = entry
			@tail = entry
		end
		self
	end

	def remove_tail
		return nil if @tail.nil?
		output = nil
		current_node = @head
		if @head.next.nil?
			@tail = nil
			@head = nil
			return current_node
		end
		node_before_tail_node = nil
		until current_node.next.nil?
			node_before_tail_node = current_node
			current_node = current_node.next
		end
		@tail = node_before_tail_node
		@tail.next = nil
		output = current_node
		current_node = nil
		output
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
		self
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

	def to_s
		if @name
			"#{@name}: head= #{@head||'nil'}, tail= #{@tail||'nil'}"
		else
			"head= #{@head||'nil'}, tail= #{@tail||'nil'}"
		end
	end
end

def bench(structure, iterations, action)
	start = Time.now
	yield 
	finish = Time.now
	puts "#{structure.capitalize} took #{finish - start} seconds to complete #{iterations} #{action}"
end

