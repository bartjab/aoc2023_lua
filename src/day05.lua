-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day05_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day05_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local seed_line = io.read()
local seeds = {}
local char_pos = 1
while char_pos <= #seed_line do
    local x, y = string.find(seed_line, "%d+", char_pos)
    table.insert(seeds, tonumber(string.sub(seed_line, x, y)))
    char_pos = y+1
end
--[[
io.write("( ")
for i=1, #seeds do
    io.write(seeds[i] .. " ")
end
print(")")
--]]
local process_maps = {}

for line in io.lines() do
    local x, y = string.find(line, "%d+")
    if x ~= nil then
        local current_map = {}
        char_pos = 1
        while char_pos <= #line do
            x, y = string.find(line, "%d+", char_pos)
            table.insert(current_map, tonumber(string.sub(line, x, y)))
            char_pos = y+1
        end
        table.insert(process_maps, current_map)
    else
        if process_maps[1] ~= nil then
            --io.write("( ")
            for seed_index=1, #seeds do
                for proc=1, #process_maps do
                    if seeds[seed_index] >= process_maps[proc][2] and seeds[seed_index] < process_maps[proc][2] + process_maps[proc][3] then
                        seeds[seed_index] = process_maps[proc][1] + seeds[seed_index] - process_maps[proc][2]
                        break
                    end
                end
                --io.write(seeds[seed_index] .. " ")
            end
            --print(")")
        end
        process_maps = {}
    end
end

local min_location = seeds[1]
for i=2, #seeds do
    if seeds[i] < min_location then min_location = seeds[i] end
end
print(min_location)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day05_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day05_input_large.txt", r)
    io.input(input_file)
end

--PROBLEM IMPLEMENTATION BEGINS HERE

local seed_line_info = io.read()
local ranges = {}
local range = {}
local char_pos = 1
while char_pos <= #seed_line_info do
    local x, y = string.find(seed_line, "%d+", char_pos)
    if #range == 0 then
        table.insert(range, tonumber(string.sub(seed_line, x, y)))
    else
        table.insert(range, range[1] + tonumber(string.sub(seed_line, x, y)) - 1)
        table.insert(ranges, range)
        range = {}
    end
    char_pos = y+1
end

io.write("( ")
for i=1, #ranges do
    io.write("{" .. ranges[i][1] .. " " .. ranges[i][2] .. "} ")
end
print(")")

local processes = {{}, {}, {}, {}, {}, {}, {}}
local process = 1
for line in io.lines() do
    local x, y = string.find(line, "map")
    if x ~= nil then
        process = process + 1
    else
        x, y = string.find(line, "%d+")
        if x ~= nil then
            local step = {}
            char_pos = 1
            while char_pos <= #line do
                x, y = string.find(line, "%d+", char_pos)
                table.insert(step, tonumber(string.sub(line, x, y)))
                char_pos = y+1
            end
            table.insert(processes[process - 1], step)
        end
    end
end

for i=1, #processes do
    for j=1, #processes[i] do
        io.write("[" .. processes[i][j][1] .. " " .. processes[i][j][2] .. " " .. processes[i][j][3] .. "] ")
    end
    print()
end

for proc=1, #processes do
    local new_ranges = {}
    while #ranges > 0 do
        for i=1, #processes[proc] do
            local src_begin = processes[proc][i][2]
            local src_end = processes[proc][i][2] + processes[proc][i][3] - 1
            local dest_begin = processes[proc][i][1]
            local ran_change = dest_begin - src_begin
            local ran_begin = -1
            local ran_end = -1
            local ran = 1
            while ran <= #ranges do
                if src_begin <= ranges[ran][2] and src_end >= ranges[ran][1] then
                    ran_begin = ranges[ran][1]
                    ran_end = ranges[ran][2]
                    if src_begin <= ran_begin and src_end >= ran_end then
                        table.insert(new_ranges, {ran_begin + ran_change, ran_end + ran_change})
                        table.remove(ranges, ran)
                    elseif src_begin <= ran_begin and src_end >= ran_begin and src_end < ran_end then
                        table.insert(new_ranges, {ran_begin + ran_change, src_end + ran_change})
                        ranges[ran][1] = src_end + 1
                        ran = ran + 1
                    elseif src_begin > ran_begin and src_end < ran_end then
                        table.insert(new_ranges, {src_begin + ran_change, src_end + ran_change})
                        ranges[ran][2] = src_begin - 1
                        table.insert(ranges, ran + 1, {src_end + 1, ran_end})
                        ran = ran + 2
                    elseif src_begin > ran_begin and src_begin <= ran_end and src_end >= ran_end then
                        table.insert(new_ranges, {src_begin + ran_change, ran_end + ran_change})
                        ranges[ran][2] = src_begin - 1
                        ran = ran + 1
                    end
                else
                    ran = ran + 1
                end
            end
        end
        table.insert(new_ranges, ranges[1])
        table.remove(ranges, 1)
    end
    ranges = new_ranges
    io.write("( ")
    for i=1, #ranges do
        io.write("{" .. ranges[i][1] .. " " .. ranges[i][2] .. "} ")
    end
    io.write(")")
    print()
end

local min_location2 = 10^10
for i=1, #ranges do
    if ranges[i][1] < min_location2 then min_location2 = ranges[i][1] end
end
print(min_location2)
io.close()