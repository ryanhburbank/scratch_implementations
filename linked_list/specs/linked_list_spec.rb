require "minitest/autorun"
require_relative '../linked_list'

describe "Entry" do
	describe "self#new" do
		let (:entry){ Entry.new(1) }

		it "sets the first node to the value passed to it" do
			entry.data.must_equal(1)
		end

		it "sets the second note(the reference) to nil" do
			entry.next.must_equal(nil)
		end
	end
end

describe "Linked List" do
	let(:list) { List.new }

	describe "#tail_insert" do
		describe "when head is nil" do
			before do
				list.tail_insert(Entry.new(1))
			end
			
			it "sets head to entry" do
				list.head.data.must_equal(1)
			end

			it "sets tail to entry" do
				list.tail.data.must_equal(1)
			end
		end

		describe "when head is not nil" do
			before do 
				list.tail_insert(Entry.new(1))
				list.tail_insert(Entry.new(2))
			end
			it "sets the previous tail's next node to entry" do
				list.head.next.data.must_equal(2)
			end

			it "sets the tail to entry" do
				list.tail.data.must_equal(2)
			end
		end
	end
	describe "#head_insert" do
		before do 
			list.head_insert(Entry.new(1))
		end
		
		describe "list is empty" do

			it "sets the head to the entry" do
				list.head.data.must_equal(1)
				list.head.next.must_equal(nil)
			end

			it "sets the tail to the entry" do
				list.tail.data.must_equal(1)
				list.tail.next.must_equal(nil)
			end
		end

		describe "list is not empty" do
			before do
				list.head_insert(Entry.new(2))
			end

			it "sets the head to the entry" do
				list.head.data.must_equal(2)
			end

			it "sets the previous head to the entry's reference node" do
				list.head.next.data.must_equal(1)
				list.head.next.next.must_equal(nil)
			end
		end
	end

	describe "#remove_tail" do
		it "returns nil when list is empty" do
			list.remove_tail.must_equal(nil)
		end

		describe "when list has 1 entry" do
			before do
				list.head_insert(Entry.new(1))
				@result = list.remove_tail
			end

			it "returns head/tail value " do
				@result.data.must_equal(1)
			end

			it "sets head to nil" do
				list.head.must_equal(nil)
			end

			it "sets the tail to nil" do
				list.tail.must_equal(nil)
			end
		end

		describe "when list has 2 or more entries" do
			before do 
				list.head_insert(Entry.new(1))
				list.head_insert(Entry.new(2))
				@result = list.remove_tail
			end
			it "returns the tail value" do
				@result.data.must_equal(1)
			end

			it "sets the tail to the previous node" do
				list.tail.data.must_equal(2)
				list.tail.next.must_equal(nil)
			end
		end
	end
end


array = Array.new
list = List.new

puts "- " * 35
puts "Benchmark Test: Array.insert vs LinkedList.insert"
puts "." * 75

bench("array",100000, "insertions") {
	100000.times { |i| array.insert(0,Entry.new(i)) }
}

puts "- " * 35

bench("linked list", 100000, "insertions") {
	100000.times { |i| list.head_insert(Entry.new(i)) }
}

puts "." * 75
puts "Benchmark Complete"
puts "- " * 35

puts "- " * 35
puts "Benchmark Test: Array[-1] vs LinkedList.tail"
puts "." * 75

bench("array",100000, "return third element") {
	100000.times { |i| array[2] }
}

puts "- " * 35

bench("linked list", 100000, "return third entry") {
	100000.times { |i| list.head.next.next }
}

puts "." * 75
puts "Benchmark Complete"
puts "- " * 35

puts "- " * 25
puts "Benchmark Test: Array.shift vs LinkedList.head_remove"
puts "." * 75

bench("array",100000, "shifts") {
	100000.times { |i| array.shift }
}

puts "- " * 35

bench("linked list", 100000, "head removals") {
	100000.times { |i| list.remove_head }
}

puts "." * 75
puts "Benchmark Complete"
puts "- " * 35

array = Array.new
list = List.new

puts "- " * 35
puts "Benchmark Test: Array.push vs LinkedList.tail_insert"
puts "." * 75

bench("array",50000, "pushes") {
	50000.times { |i| array.push(Entry.new(i)) }
}

puts "-" * 75

bench("linked list", 50000, "tail insertions") {
	50000.times { |i| list.tail_insert(Entry.new(i)) }
}

puts "." * 75
puts "Benchmark Complete"
puts "- " * 35

puts "- " * 35
puts "Benchmark Test: Array.pop vs LinkedList.tail_remove"
puts "." * 75

bench("array",1000, "pops") {
	1000.times { |i| array.pop }
}

puts "-" * 75

bench("linked list", 1000, "tail removals") {
	1000.times { |i| list.remove_tail }
}

puts "." * 75
puts "Benchmark Complete"
puts "-" * 75