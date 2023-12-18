-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day13_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day13_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local patterns = {}

local index = 1
for line in io.lines() do
    if line == "" then
        index = index + 1
    else
        if patterns[index] == nil then
            patterns[index] = {}
            patterns[index][1] = {}
            for j=1, #line do
                patterns[index][1][j] = string.sub(line, j, j)
            end
        else
            patterns[index][#patterns[index] + 1] = {}
            for j=1, #line do
                patterns[index][#patterns[index]][j] = string.sub(line, j, j)
            end
        end
    end
end
--[[
for i=1, #patterns do
    for j=1, #patterns[i] do
        for k=1, #patterns[i][j] do
            io.write(patterns[i][j][k])
        end
        print()
    end
    print()
end
--]]
local result = 0

for i=1, #patterns do
    -- searching for vertical line of symmetry
    for j=1, #patterns[i][1] - 1 do
        if patterns[i][1][j] == patterns[i][1][j + 1] then
            local isSymmetry = true
            local left_pos = j
            local right_pos = j+1
            while left_pos >= 1 and right_pos <= #patterns[i][1] do
                for k=1, #patterns[i] do
                    if patterns[i][k][left_pos] ~= patterns[i][k][right_pos] then
                        isSymmetry = false
                        break
                    end
                end
                if isSymmetry == false then
                    break
                else
                    left_pos = left_pos - 1
                    right_pos = right_pos + 1
                end
            end
            if isSymmetry then result = result + j end
        end
    end
    -- searching for horizontal line of symmetry
    for j=1, #patterns[i] - 1 do
        if patterns[i][j][1] == patterns[i][j + 1][1] then
            local isSymmetry = true
            local up_pos = j
            local down_pos = j+1
            while up_pos >= 1 and down_pos <= #patterns[i] do
                for k=1, #patterns[i][1] do
                    if patterns[i][up_pos][k] ~= patterns[i][down_pos][k] then
                        isSymmetry = false
                        break
                    end
                end
                if isSymmetry == false then
                    break
                else
                    up_pos = up_pos - 1
                    down_pos = down_pos + 1
                end
            end
            if isSymmetry then result = result + 100*j end
        end
    end
end
print(result)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day13_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day13_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function SearchVerticalLine(t, avoid_pos, avoid_type)
    for j=1, #t[1] - 1 do
        if t[1][j] == t[1][j + 1] then
            local isSymmetry = true
            local left_pos = j
            local right_pos = j+1
            while left_pos >= 1 and right_pos <= #t[1] do
                for k=1, #t do
                    if t[k][left_pos] ~= t[k][right_pos] then
                        isSymmetry = false
                        break
                    end
                end
                if isSymmetry == false then
                    break
                else
                    left_pos = left_pos - 1
                    right_pos = right_pos + 1
                end
            end
            if isSymmetry then
                if avoid_pos == j and avoid_type == "vertical" then isSymmetry = false
                else return j, "vertical" end
            end
        end
    end
    return nil
end

local function SearchHorizontalLine(t, avoid_pos, avoid_type)
    for j=1, #t - 1 do
        if t[j][1] == t[j + 1][1] then
            local isSymmetry = true
            local up_pos = j
            local down_pos = j+1
            while up_pos >= 1 and down_pos <= #t do
                for k=1, #t[1] do
                    if t[up_pos][k] ~= t[down_pos][k] then
                        isSymmetry = false
                        break
                    end
                end
                if isSymmetry == false then
                    break
                else
                    up_pos = up_pos - 1
                    down_pos = down_pos + 1
                end
            end
            if isSymmetry then
                if avoid_pos == j and avoid_type == "horizontal" then isSymmetry = false
                else return j, "horizontal" end
            end
        end
    end
    return nil
end

local patterns = {}

local index = 1
for line in io.lines() do
    if line == "" then
        index = index + 1
    else
        if patterns[index] == nil then
            patterns[index] = {}
            patterns[index][1] = {}
            for j=1, #line do
                patterns[index][1][j] = string.sub(line, j, j)
            end
        else
            patterns[index][#patterns[index] + 1] = {}
            for j=1, #line do
                patterns[index][#patterns[index]][j] = string.sub(line, j, j)
            end
        end
    end
end

local result = 0

for i=1, #patterns do
    local hasNewSymmetry = false
    -- searching for old line of symmetry
    local sym_pos
    local sym_type

    local pos, type = SearchVerticalLine(patterns[i], 0, "")
    if pos == nil then pos, type = SearchHorizontalLine(patterns[i], 0, "") end
    sym_pos = pos
    sym_type = type
    --print(sym_pos .. sym_type)

    -- searching for new symmetry
    for x=1, #patterns[i] do
        for y=1, #patterns[i][1] do
            if patterns[i][x][y] == "." then
                patterns[i][x][y] = "#"
            else
                patterns[i][x][y] = "."
            end

            pos, type = SearchVerticalLine(patterns[i], sym_pos, sym_type)
            if pos == nil then pos, type = SearchHorizontalLine(patterns[i], sym_pos, sym_type) end

            if pos ~= nil then
                --print(pos .. type)
                if pos ~= sym_pos or type ~= sym_type then
                    sym_pos = pos
                    sym_type = type
                    hasNewSymmetry = true
                    break
                end
            end


            if patterns[i][x][y] == "." then
                patterns[i][x][y] = "#"
            else
                patterns[i][x][y] = "."
            end
        end
        if hasNewSymmetry then break end
    end
    if hasNewSymmetry then
        if sym_type == "vertical" then result = result + sym_pos
        else result = result + (100*sym_pos) end
    end
end
--[[
for i=1, #patterns do
    for j=1, #patterns[i] do
        for k=1, #patterns[i][j] do
            io.write(patterns[i][j][k])
        end
        print()
    end
    print()
end
--]]
print(result)
io.close()