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
end
