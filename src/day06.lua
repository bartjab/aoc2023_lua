-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day06_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day06_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local time_info = io.read()
local times = {}
local curr_char = 1
while curr_char <= #time_info do
    local x, y = string.find(time_info, "%d+", curr_char)
    if x ~= nil then
        table.insert(times, tonumber(string.sub(time_info, x, y)))
    else break
    end
    curr_char = y+1
end

local dist_info = io.read()
local distances = {}
curr_char = 1
while curr_char <= #dist_info do
    local x, y = string.find(dist_info, "%d+", curr_char)
    if x ~= nil then
        table.insert(distances, tonumber(string.sub(dist_info, x, y)))
    else break
    end
    curr_char = y+1
end

local record_ways = {}
for i=1, #times do
    local race_records = 0
    for t=1, times[i] do
        local reach = (times[i] - t) * t
        if reach > distances[i] then
            race_records = race_records + 1
        end
    end
    table.insert(record_ways, race_records)
end

local result
if record_ways == nil then
    result = 0
else
    result = 1
    for i=1, #record_ways do
        result = result * record_ways[i]
    end
end
print(result)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day06_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day06_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local time_info = io.read()
local time = ""
local curr_char = 1
while curr_char <= #time_info do
    local x, y = string.find(time_info, "%d+", curr_char)
    if x ~= nil then
        time = time .. string.sub(time_info, x, y)
    else break
    end
    curr_char = y+1
end

local dist_info = io.read()
local distance = ""
curr_char = 1
while curr_char <= #dist_info do
    local x, y = string.find(dist_info, "%d+", curr_char)
    if x ~= nil then
        distance = distance .. string.sub(dist_info, x, y)
    else break
    end
    curr_char = y+1
end

time = tonumber(time)
distance = tonumber(distance)
local race_records = 0
for t=1, time do
    local reach = (time - t) * t
    if reach > distance then
        race_records = race_records + 1
    end
end
print(race_records)