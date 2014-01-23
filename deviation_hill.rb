# def hill(v)
#     x = 0 
#     last = v[0] #3
#     modify = 0 
#     v.each_with_index do |num, i|
#         if (last >= v[i] + x)
#             modify = (last - (v[i] + x)) / 2 + 1
#             x += modify
#             last -= modify
#             last += 1
#         else
#             if (last < v[i] - x)
#                 last = v[i] - x
#             else
#                 last += 1
#             end
#         end
#     end
#     x
# end

# puts hill([3,3,2])

#cut array into slices d length long, then find median of each
#slice, and return the largest median found
def find_deviation(v, d)
    max_value = 0
    counter = 0
    current = nil
    median = 0
    while (counter <= v.length - d) do
        current = v.slice(counter,d)    
        median = current.sort.last - current.sort.first
        max_value = median if median > max_value
        counter += 1
    end
    max_value
end

find_deviation([6,9,4,7,4,1],3)
