-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day11_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day11_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local grid = {}
for line in io.lines() do
    local row = {}
    for i=1, #line do
        table.insert(row, string.sub(line, i, i))
    end
    table.insert(grid, row)
end
--[[
for i=1, #grid do
    print()
    for j=1, #grid[i] do
        io.write(grid[i][j])
    end
end
--]]
local curr_row = 1
while curr_row <= #grid do
    local isEmpty = true
    for i=1, #grid[curr_row] do
        if grid[curr_row][i] == "#" then isEmpty = false break end
    end
    if isEmpty then table.insert(grid, curr_row, grid[curr_row]) curr_row = curr_row + 1 end
    curr_row = curr_row + 1
end
local curr_col = 1
while curr_col <= #grid[1] do
    local isEmpty = true
    for i=1, #grid do
        if grid[i][curr_col] == "#" then isEmpty = false break end
    end
    if isEmpty then
        for i=1, #grid do
            table.insert(grid[i], curr_col,".")
        end
        curr_col = curr_col + 1
    end
    curr_col = curr_col + 1
end
--[[
print()
for i=1, #grid do
    print()
    for j=1, #grid[1] do
        io.write(grid[i][j])
    end
end
--]]
local galaxies_pos = {}
for i=1, #grid do
    for j=1, #grid[1] do
        if grid[i][j] == "#" then table.insert(galaxies_pos, {i, j}) end
    end
end

local distance_sum = 0
for i=1, #galaxies_pos - 1 do
    for j=i+1, #galaxies_pos do
        distance_sum = distance_sum + (galaxies_pos[j][1] - galaxies_pos[i][1]) + math.abs(galaxies_pos[j][2] - galaxies_pos[i][2])
    end
end

print(distance_sum)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day11_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day11_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local grid = {}
for line in io.lines() do
    local row = {}
    for i=1, #line do
        table.insert(row, string.sub(line, i, i))
    end
    table.insert(grid, row)
end

--[[
for i=1, #grid do
    print()
    for j=1, #grid[i] do
        io.write(grid[i][j])
    end
end
--]]

local empty_rows = {}
for i = 1, #grid do
    local isEmpty = true
    for j=1, #grid[i] do
        if grid[i][j] == "#" then isEmpty = false break end
    end
    if isEmpty then table.insert(empty_rows, i) end
end

local empty_cols = {}
for j=1, #grid[1] do
    local isEmpty = true
    for i=1, #grid do
        if grid[i][j] == "#" then isEmpty = false break end
    end
    if isEmpty then table.insert(empty_cols, j) end
end

--[[
print()
for i=1, #grid do
    print()
    for j=1, #grid[1] do
        io.write(grid[i][j])
    end
end
--]]

local galaxies_pos = {}
for i=1, #grid do
    for j=1, #grid[1] do
        if grid[i][j] == "#" then table.insert(galaxies_pos, {i, j}) end
    end
end

local distance_sum = 0
for i=1, #galaxies_pos - 1 do
    for j=i+1, #galaxies_pos do
        local row_begin = galaxies_pos[i][1]
        local row_end = galaxies_pos[j][1]
        for k=1, #empty_rows do
            if row_begin < empty_rows[k] and empty_rows[k] < row_end then distance_sum = distance_sum + 1000000 - 1
            elseif empty_rows[k] > row_end then break end
        end
        local col_begin
        local col_end
        if galaxies_pos[i][2] < galaxies_pos[j][2] then
            col_begin = galaxies_pos[i][2]
            col_end = galaxies_pos[j][2]
        else
            col_begin = galaxies_pos[j][2]
            col_end = galaxies_pos[i][2]
        end
        for k=1, #empty_cols do
            if col_begin < empty_cols[k] and empty_cols[k] < col_end then distance_sum = distance_sum + 1000000 - 1
            elseif empty_cols[k] > col_end then break end
        end
        distance_sum = distance_sum + (galaxies_pos[j][1] - galaxies_pos[i][1]) + math.abs(galaxies_pos[j][2] - galaxies_pos[i][2])
    end
end

print(distance_sum)
io.close()

