-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day01_input_small_part1.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day01_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE
local first_digit = nil
local second_digit = nil
local val_sum = 0

for line in io.lines() do
    first_digit = nil
    second_digit = nil
    for i=1,#line do
        if tonumber(string.sub(line,i,i)) ~= nil then
            first_digit = string.sub(line,i,i)
        end
        if first_digit ~= nil then
            break
        end
    end
    for i=#line,1,-1 do
        if tonumber(string.sub(line,i,i)) ~= nil then
            second_digit = string.sub(line,i,i)
        end
        if second_digit ~= nil then
            break
        end
    end
    local line_val = tonumber(first_digit .. second_digit)
    -- print(line_val)
    val_sum = val_sum + line_val
end

print(val_sum)
io.close()
-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day01_input_small_part2.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day01_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE
local first_digit = nil
local second_digit = nil
local val_sum = 0

for line in io.lines() do
    first_digit = nil
    second_digit = nil
    local i = 0
    local min_begin = math.huge
    local max_begin = 0
    local min_n = 0
    local max_n = 0
    local num_tabs = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
    while true do
        for n, num in ipairs(num_tabs) do
            local k, l = string.find(line, num, i+1)
            if k ~= nil and k < min_begin then
                min_begin = k
                min_n = n
            end
            if k ~= nil and k > max_begin then
                max_begin = k
                max_n = n
            end
        end
        i = i + 1
        if i == string.len(line) then break end
    end



    if min_n <= 9 then
        first_digit = min_n
    else
        first_digit = tonumber(num_tabs[min_n])
    end
    if max_n <= 9 then
        second_digit = max_n
    else
        second_digit = tonumber(num_tabs[max_n])
    end

    print(min_begin, max_begin, first_digit, second_digit)

    local line_val = tonumber(first_digit .. second_digit)
    -- print(line_val)
    val_sum = val_sum + line_val
end

print(val_sum)