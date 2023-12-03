-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day02_input_small_part1.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day02_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local id_sum = 0

for line in io.lines() do
    local red_cubes = 0
    local green_cubes = 0
    local blue_cubes = 0
    local game_id = 0
    local line_pos = 1
    local num_occurrence = 0
    while true do
        local i, j = string.find(line, "%d+", line_pos)
        if i ~= nil then num_occurrence = num_occurrence + 1 else break end
        if num_occurrence == 1 then
            game_id = tonumber(string.sub(line, i, j))
        else
            if string.sub(line, j+2, j+2) == "r" then
                if tonumber(string.sub(line, i, j)) > red_cubes then red_cubes = tonumber(string.sub(line, i, j)) end
            elseif string.sub(line, j+2, j+2) == "g" then
                if tonumber(string.sub(line, i, j)) > green_cubes then green_cubes = tonumber(string.sub(line, i, j)) end
            elseif string.sub(line, j+2, j+2) == "b" then
                if tonumber(string.sub(line, i, j)) > blue_cubes then blue_cubes = tonumber(string.sub(line, i, j)) end
            end
        end
        line_pos = j+1
    end
    -- print(red_cubes, green_cubes, blue_cubes)
    if red_cubes <= 12 and green_cubes <= 13 and blue_cubes <= 14 then
        id_sum = id_sum + game_id
    end
end

print(id_sum)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day02_input_small_part2.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day02_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local power_sum = 0

for line in io.lines() do
    local red_cubes = 0
    local green_cubes = 0
    local blue_cubes = 0
    local game_id = 0
    local line_pos = 1
    local num_occurrence = 0
    while true do
        local i, j = string.find(line, "%d+", line_pos)
        if i ~= nil then num_occurrence = num_occurrence + 1 else break end
        if num_occurrence == 1 then
            game_id = tonumber(string.sub(line, i, j))
        else
            if string.sub(line, j+2, j+2) == "r" then
                if tonumber(string.sub(line, i, j)) > red_cubes then red_cubes = tonumber(string.sub(line, i, j)) end
            elseif string.sub(line, j+2, j+2) == "g" then
                if tonumber(string.sub(line, i, j)) > green_cubes then green_cubes = tonumber(string.sub(line, i, j)) end
            elseif string.sub(line, j+2, j+2) == "b" then
                if tonumber(string.sub(line, i, j)) > blue_cubes then blue_cubes = tonumber(string.sub(line, i, j)) end
            end
        end
        line_pos = j+1
    end
    print(red_cubes, green_cubes, blue_cubes)
    local game_power = red_cubes * green_cubes * blue_cubes
    power_sum = power_sum + game_power
end

print(power_sum)