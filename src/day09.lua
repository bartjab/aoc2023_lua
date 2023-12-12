-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day09_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day09_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local result = 0
for line in io.lines() do
    local init_numbers = {}
    local curr_char = 1
    while curr_char < #line do
        local i, j = string.find(line, "[-]?%d+", curr_char)
        table.insert(init_numbers, tonumber(string.sub(line, i, j)))
        curr_char = j + 1
    end
    local iter = {init_numbers}
    for i=1, #iter[1] - 1 do
        local curr_step = iter[i]
        local next_step = {}
        for j=1, #curr_step - 1 do
            table.insert(next_step, curr_step[j+1] - curr_step[j])
        end
        table.insert(iter, next_step)
        local is_zeros = true
        for j=1, #iter[#iter] do
            if iter[#iter][j] ~= 0 then is_zeros = false break end
        end
        if is_zeros == true then break end
    end
    for i=1, #iter do
        for j=1, #iter[i] do
            io.write(iter[i][j] .. " ")
        end
        print()
    end
    table.insert(iter[#iter], 0)
    for i=#iter-1, 1, -1 do
        table.insert(iter[i], iter[i+1][#iter[i+1]] + iter[i][#iter[i]])
    end
    print()
    for i=1, #iter do
        for j=1, #iter[i] do
            io.write(iter[i][j] .. " ")
        end
        print()
    end
    print()
    result = result + iter[1][#iter[1]]
end
print(result)

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day09_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day09_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local result2 = 0
for line in io.lines() do
    local init_numbers = {}
    local curr_char = 1
    while curr_char < #line do
        local i, j = string.find(line, "[-]?%d+", curr_char)
        table.insert(init_numbers, tonumber(string.sub(line, i, j)))
        curr_char = j + 1
    end
    local iter = {init_numbers}
    for i=1, #iter[1] - 1 do
        local curr_step = iter[i]
        local next_step = {}
        for j=1, #curr_step - 1 do
            table.insert(next_step, curr_step[j+1] - curr_step[j])
        end
        table.insert(iter, next_step)
        local is_zeros = true
        for j=1, #iter[#iter] do
            if iter[#iter][j] ~= 0 then is_zeros = false break end
        end
        if is_zeros == true then break end
    end
    for i=1, #iter do
        for j=1, #iter[i] do
            io.write(iter[i][j] .. " ")
        end
        print()
    end
    table.insert(iter[#iter], 1, 0)
    for i=#iter-1, 1, -1 do
        table.insert(iter[i], 1, -iter[i+1][1] + iter[i][1])
    end
    print()
    for i=1, #iter do
        for j=1, #iter[i] do
            io.write(iter[i][j] .. " ")
        end
        print()
    end
    print()
    result2 = result2 + iter[1][1]
end
print(result2)