#simple benchmark between linked_list and array

Cell = Struct.new(:value, :next)

list = Cell.new("head", nil)

array = []

def linked_list(value, cell)
	return Cell.new(value, cell)
end

def bench(structure, iterations)
	start = Time.now
	yield 
	finish = Time.now
	puts "#{structure} took #{finish - start} to complete #{iterations} insertions"
end

bench("array",100000) {
	100000.times { |i| array.insert(0,i) }
}

bench("linked list", 100000) {
	100000.times { |i| list = linked_list(i, list) }
}




