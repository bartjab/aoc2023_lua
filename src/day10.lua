-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day10_input_small_part1.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day10_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function isConnectedUp(char)
    return char == "|" or char == "F" or char == "7"
end

local function isConnectedDown(char)
    return char == "|" or char == "L" or char == "J"
end

local function isConnectedLeft(char)
    return char == "-" or char == "F" or char == "L"
end

local function isConnectedRight(char)
    return char == "-" or char == "J" or char == "7"
end


local grid = {}
for line in io.lines() do
    local row_pipes = {}
    for i=1, #line do
        table.insert(row_pipes, string.sub(line, i, i))
    end
    table.insert(grid, row_pipes)
end
local row
local col
for i=1, #grid do
    local isStartFound = false
    for j=1, #grid[i] do
        if grid[i][j] == "S" then
            row = i
            col = j
            isStartFound = true
            break
        end
    end
    if isStartFound then break end
end

local starting_point_pipe = ""
if row > 1 and row < #grid and isConnectedUp(grid[row-1][col]) and isConnectedDown(grid[row+1][col]) then starting_point_pipe = "|"
elseif col > 1 and col < #grid[1] and isConnectedLeft(grid[row][col-1]) and isConnectedRight(grid[row][col+1]) then starting_point_pipe = "-"
elseif row > 1 and col < #grid[1] and isConnectedUp(grid[row-1][col]) and isConnectedRight(grid[row][col+1]) then starting_point_pipe = "L"
elseif row > 1 and col > 1 and isConnectedUp(grid[row-1][col]) and isConnectedLeft(grid[row][col-1]) then starting_point_pipe = "J"
elseif row < #grid and col > 1 and isConnectedDown(grid[row+1][col]) and isConnectedLeft(grid[row][col-1]) then starting_point_pipe = "7"
elseif row < #grid and col < #grid[1] and isConnectedDown(grid[row+1][col]) and isConnectedRight(grid[row][col+1]) then starting_point_pipe = "F"
end

local cycle = {starting_point_pipe}
local starting_row = row
local starting_col = col
--print(starting_point_pipe)
--print(row .. " " .. col)
local previous_neighbor_loc = {starting_row, starting_col}
if starting_point_pipe == "|" then row = row + 1
elseif starting_point_pipe == "-" then col = col + 1
elseif starting_point_pipe == "L" then col = col + 1
elseif starting_point_pipe == "J" then row = row + 1
elseif starting_point_pipe == "7" then row = row + 1
elseif starting_point_pipe == "F" then col = col + 1
end
--print(row .. " " .. col)

while row ~= starting_row or col ~= starting_col do
    table.insert(cycle, grid[row][col])
    --print(row .. " " .. col)
    local neighbor1_loc
    local neighbor2_loc
    if grid[row][col] == "|" then
        neighbor1_loc = {row-1, col}
        neighbor2_loc = {row+1, col}
    elseif grid[row][col] == "-" then
        neighbor1_loc = {row, col-1}
        neighbor2_loc = {row, col+1}
    elseif grid[row][col] == "L" then
        neighbor1_loc = {row-1, col}
        neighbor2_loc = {row, col+1}
    elseif grid[row][col] == "J" then
        neighbor1_loc = {row-1, col}
        neighbor2_loc = {row, col-1}
    elseif grid[row][col] == "7" then
        neighbor1_loc = {row+1, col}
        neighbor2_loc = {row, col-1}
    elseif grid[row][col] == "F" then
        neighbor1_loc = {row+1, col}
        neighbor2_loc = {row, col+1}
    end
    if neighbor1_loc[1] == previous_neighbor_loc[1] and neighbor1_loc[2] == previous_neighbor_loc[2] then
        previous_neighbor_loc = {row, col}
        row = neighbor2_loc[1]
        col = neighbor2_loc[2]
    elseif neighbor2_loc[1] == previous_neighbor_loc[1] and neighbor2_loc[2] == previous_neighbor_loc[2] then
        previous_neighbor_loc = {row, col}
        row = neighbor1_loc[1]
        col = neighbor1_loc[2]
    end
end

--[[
for i=1, #cycle do
    io.write(cycle[i] .. " ")
end
--]]

local result
if #cycle % 2 == 0 then
    result = #cycle / 2
else
    result = (#cycle - 1) / 2
end
print(result)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day10_input_small_part2.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day10_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function isConnectedUp(char)
    return char == "|" or char == "F" or char == "7"
end

local function isConnectedDown(char)
    return char == "|" or char == "L" or char == "J"
end

local function isConnectedLeft(char)
    return char == "-" or char == "F" or char == "L"
end

local function isConnectedRight(char)
    return char == "-" or char == "J" or char == "7"
end

local grid2 = {}
for line in io.lines() do
    local row_pipes = {}
    for i=1, #line do
        table.insert(row_pipes, string.sub(line, i, i))
    end
    table.insert(grid2, row_pipes)
end

--[[
for i=1, #grid2 do
    print()
    for j=1, #grid2[i] do
        io.write(grid2[i][j] .. " ")
    end
end
--]]

local row
local col
for i=1, #grid2 do
    local isStartFound = false
    for j=1, #grid2[i] do
        if grid2[i][j] == "S" then
            row = i
            col = j
            isStartFound = true
            break
        end
    end
    if isStartFound then break end
end

local starting_point_pipe = ""
if row > 1 and row < #grid2 and isConnectedUp(grid2[row-1][col]) and isConnectedDown(grid2[row+1][col]) then starting_point_pipe = "|"
elseif col > 1 and col < #grid2[1] and isConnectedLeft(grid2[row][col-1]) and isConnectedRight(grid2[row][col+1]) then starting_point_pipe = "-"
elseif row > 1 and col < #grid2[1] and isConnectedUp(grid2[row-1][col]) and isConnectedRight(grid2[row][col+1]) then starting_point_pipe = "L"
elseif row > 1 and col > 1 and isConnectedUp(grid2[row-1][col]) and isConnectedLeft(grid2[row][col-1]) then starting_point_pipe = "J"
elseif row < #grid2 and col > 1 and isConnectedDown(grid2[row+1][col]) and isConnectedLeft(grid2[row][col-1]) then starting_point_pipe = "7"
elseif row < #grid2 and col < #grid2[1] and isConnectedDown(grid2[row+1][col]) and isConnectedRight(grid2[row][col+1]) then starting_point_pipe = "F"
end

local cycle_with_pos = {}
table.insert(cycle_with_pos, {starting_point_pipe, row, col})
local starting_row = row
local starting_col = col
--print(starting_point_pipe)
--print(row .. " " .. col)
local previous_neighbor_loc = {starting_row, starting_col}
if starting_point_pipe == "|" then row = row + 1
elseif starting_point_pipe == "-" then col = col + 1
elseif starting_point_pipe == "L" then col = col + 1
elseif starting_point_pipe == "J" then row = row + 1
elseif starting_point_pipe == "7" then row = row + 1
elseif starting_point_pipe == "F" then col = col + 1
end
--print(row .. " " .. col)
while row ~= starting_row or col ~= starting_col do
    table.insert(cycle_with_pos, {grid2[row][col], row, col})
    --print(row .. " " .. col)
    local neighbor1_loc
    local neighbor2_loc
    if grid2[row][col] == "|" then
        neighbor1_loc = {row-1, col}
        neighbor2_loc = {row+1, col}
    elseif grid2[row][col] == "-" then
        neighbor1_loc = {row, col-1}
        neighbor2_loc = {row, col+1}
    elseif grid2[row][col] == "L" then
        neighbor1_loc = {row-1, col}
        neighbor2_loc = {row, col+1}
    elseif grid2[row][col] == "J" then
        neighbor1_loc = {row-1, col}
        neighbor2_loc = {row, col-1}
    elseif grid2[row][col] == "7" then
        neighbor1_loc = {row+1, col}
        neighbor2_loc = {row, col-1}
    elseif grid2[row][col] == "F" then
        neighbor1_loc = {row+1, col}
        neighbor2_loc = {row, col+1}
    end
    if neighbor1_loc[1] == previous_neighbor_loc[1] and neighbor1_loc[2] == previous_neighbor_loc[2] then
        previous_neighbor_loc = {row, col}
        row = neighbor2_loc[1]
        col = neighbor2_loc[2]
    elseif neighbor2_loc[1] == previous_neighbor_loc[1] and neighbor2_loc[2] == previous_neighbor_loc[2] then
        previous_neighbor_loc = {row, col}
        row = neighbor1_loc[1]
        col = neighbor1_loc[2]
    end
end

--[[
for i=1, #cycle do
    io.write(cycle[i] .. " ")
end
--]]

for i=1, #grid2 do
    for j=1, #grid2[i] do
        local isInCycle = false
        for k=1, #cycle_with_pos do
            if i == cycle_with_pos[k][2] and j == cycle_with_pos[k][3] then isInCycle = true break end
        end
        if not isInCycle then grid2[i][j] = "." end
    end
end

grid2[starting_row][starting_col] = starting_point_pipe
--[[
print()
for i=1, #grid2 do
    print()
    for j=1, #grid2[i] do
        io.write(grid2[i][j] .. " ")
    end
end
--]]
local inside_cells = 0
for i=1, #grid2 do
    local isInRegion = false
    local curr_char = 1
    while curr_char <= #grid2[i] do
        if grid2[i][curr_char] == "|" then
            isInRegion = not isInRegion
        elseif grid2[i][curr_char] == "F" then
            local begin = "F"
            local ending
            curr_char = curr_char + 1
            if grid2[i][curr_char] == "-" then
                while grid2[i][curr_char] == "-" do
                    curr_char = curr_char + 1
                    ending = grid2[i][curr_char]
                end
            else
                ending = grid2[i][curr_char]
            end
            local shape = begin .. ending
            if shape == "FJ" then isInRegion = not isInRegion end
        elseif grid2[i][curr_char] == "L" then
            local begin = "L"
            local ending
            curr_char = curr_char + 1
            if grid2[i][curr_char] == "-" then
                while grid2[i][curr_char] == "-" do
                    curr_char = curr_char + 1
                    ending = grid2[i][curr_char]
                end
            else
                ending = grid2[i][curr_char]
            end
            local shape = begin .. ending
            if shape == "L7" then isInRegion = not isInRegion end
        elseif grid2[i][curr_char] == "." then
            if isInRegion then inside_cells = inside_cells + 1 end
        end
        curr_char = curr_char + 1
    end
end

print(inside_cells)