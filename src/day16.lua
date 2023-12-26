-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day16_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day16_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function FindBeamChange(map, beam)
    local char_row = beam[1]
    local char_col = beam[2]
    local curr_char = map[char_row][char_col]
    while true do
        if beam[3] == "Right" then
            if char_col <= #map[1] and curr_char ~= "|" and curr_char ~= "/" and curr_char ~= "\\" then char_col = char_col + 1
            else break end
        elseif beam[3] == "Left" then
            if char_col >= 1 and curr_char ~= "|" and curr_char ~= "/" and curr_char ~= "\\" then char_col = char_col - 1
            else break end
        elseif beam[3] == "Up" then
            if char_row >= 1 and curr_char ~= "-" and curr_char ~= "/" and curr_char ~= "\\" then char_row = char_row - 1
            else break end
        elseif beam[3] == "Down" then
            if char_row <= #map and curr_char ~= "-" and curr_char ~= "/" and curr_char ~= "\\" then char_row = char_row + 1
            else break end
        end
        if char_col < 1 or char_col > #map[1] or char_row < 1 or char_row > #map then break end
        curr_char = map[char_row][char_col]
    end
    if char_col < 1 or char_col > #map[1] or char_row < 1 or char_row > #map then return nil end
    return curr_char, char_row, char_col
end

local function AddIfNewBeam(t, beam)
    local is_new = true
    for i=1, #t do
        if t[i][1] == beam[1] and t[i][2] == beam[2] and t[i][3] == beam[3] then
            is_new = false
            break
        end
    end
    if is_new then table.insert(t, beam) end
end

local map = {}
for line in io.lines() do
    local row = {}
    for i=1, #line do
        row[i] = string.sub(line, i, i)
    end
    table.insert(map, row)
end

--[[
for i=1, #map do
    print()
    for j=1, #map[i] do
        io.write(map[i][j])
    end
end
--]]

local beams = {}
beams[1] = {1, 1, "Right", false}      --row, column, direction, if_checked

local beam_iter = 1
while true do
    --print(beams[beam_iter][1], beams[beam_iter][2], beams[beam_iter][3])
    if beams[beam_iter][4] == false then
        beams[beam_iter][4] = true
        local change_char, change_row, change_col = FindBeamChange(map, beams[beam_iter])
        if change_char ~= nil then
            local is_beam_new
            local new_beam
            if beams[beam_iter][3] == "Right" then
                if change_row >= 2 and (change_char == "/" or change_char == "|") then
                    new_beam = {change_row - 1, change_col, "Up", false}
                    AddIfNewBeam(beams, new_beam) end
                if change_row < #map and (change_char == "\\" or change_char == "|") then
                    new_beam = {change_row + 1, change_col, "Down", false}
                    AddIfNewBeam(beams, new_beam) end
            elseif beams[beam_iter][3] == "Left" then
                if change_row >= 2 and (change_char == "\\" or change_char == "|") then
                    new_beam = {change_row - 1, change_col, "Up", false}
                    AddIfNewBeam(beams, new_beam) end
                if change_row < #map and (change_char == "/" or change_char == "|") then
                    new_beam = {change_row + 1, change_col, "Down", false}
                    AddIfNewBeam(beams, new_beam) end
            elseif beams[beam_iter][3] == "Up" then
                if change_col >= 2 and (change_char == "\\" or change_char == "-") then
                    new_beam = {change_row, change_col - 1, "Left", false}
                    AddIfNewBeam(beams, new_beam) end
                if change_col < #map[1] and (change_char == "/" or change_char == "-") then
                    new_beam = {change_row, change_col + 1, "Right", false}
                    AddIfNewBeam(beams, new_beam) end
            elseif beams[beam_iter][3] == "Down" then
                if change_col >= 2 and (change_char == "/" or change_char == "-") then
                    new_beam = {change_row, change_col - 1, "Left", false}
                    AddIfNewBeam(beams, new_beam) end
                if change_col < #map[1] and (change_char == "\\" or change_char == "-") then
                    new_beam = {change_row, change_col + 1, "Right", false}
                    AddIfNewBeam(beams, new_beam) end
            end
        end
    end
    beam_iter = beam_iter + 1
    if beam_iter > #beams then break end
end

local energized_map = {}
for i=1, #map do
    energized_map[i] = {}
    for j=1, #map[1] do
        energized_map[i][j] = "."
    end
end

for i=1, #beams do
    local row = beams[i][1]
    local col = beams[i][2]
    local curr_char = map[row][col]
    while true do
        energized_map[row][col] = "#"
        if beams[i][3] == "Right" then
            if col <= #map[1] and curr_char ~= "|" and curr_char ~= "/" and curr_char ~= "\\" then col = col + 1
            else break end
        elseif beams[i][3] == "Left" then
            if col >= 1 and curr_char ~= "|" and curr_char ~= "/" and curr_char ~= "\\" then col = col - 1
            else break end
        elseif beams[i][3] == "Up" then
            if row >= 1 and curr_char ~= "-" and curr_char ~= "/" and curr_char ~= "\\" then row = row - 1
            else break end
        elseif beams[i][3] == "Down" then
            if row <= #map and curr_char ~= "-" and curr_char ~= "/" and curr_char ~= "\\" then row = row + 1
            else break end
        end
        if row >= 1 and row <= #map and col >= 1 and col <= #map[1] then curr_char = map[row][col] else break end
    end
end
--[[
for i=1, #energized_map do
    print()
    for j=1, #energized_map[i] do
        io.write(energized_map[i][j])
    end
end
--]]
local energized_count = 0
for i=1, #energized_map do
    for j=1, #energized_map[i] do
        if energized_map[i][j] == "#" then energized_count = energized_count + 1 end
    end
end
print(energized_count)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day16_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day16_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function FindBeamChange(map, beam)
    local char_row = beam[1]
    local char_col = beam[2]
    local curr_char = map[char_row][char_col]
    while true do
        if beam[3] == "Right" then
            if char_col <= #map[1] and curr_char ~= "|" and curr_char ~= "/" and curr_char ~= "\\" then char_col = char_col + 1
            else break end
        elseif beam[3] == "Left" then
            if char_col >= 1 and curr_char ~= "|" and curr_char ~= "/" and curr_char ~= "\\" then char_col = char_col - 1
            else break end
        elseif beam[3] == "Up" then
            if char_row >= 1 and curr_char ~= "-" and curr_char ~= "/" and curr_char ~= "\\" then char_row = char_row - 1
            else break end
        elseif beam[3] == "Down" then
            if char_row <= #map and curr_char ~= "-" and curr_char ~= "/" and curr_char ~= "\\" then char_row = char_row + 1
            else break end
        end
        if char_col < 1 or char_col > #map[1] or char_row < 1 or char_row > #map then break end
        curr_char = map[char_row][char_col]
    end
    if char_col < 1 or char_col > #map[1] or char_row < 1 or char_row > #map then return nil end
    return curr_char, char_row, char_col
end

local function AddIfNewBeam(t, beam)
    local is_new = true
    for i=1, #t do
        if t[i][1] == beam[1] and t[i][2] == beam[2] and t[i][3] == beam[3] then
            is_new = false
            break
        end
    end
    if is_new then table.insert(t, beam) end
end

local function GetEnergizedCount(map, beams)
    local beam_iter = 1
    while true do
        --print(beams[beam_iter][1], beams[beam_iter][2], beams[beam_iter][3])
        if beams[beam_iter][4] == false then
            beams[beam_iter][4] = true
            local change_char, change_row, change_col = FindBeamChange(map, beams[beam_iter])
            if change_char ~= nil then
                local is_beam_new
                local new_beam
                if beams[beam_iter][3] == "Right" then
                    if change_row >= 2 and (change_char == "/" or change_char == "|") then
                        new_beam = {change_row - 1, change_col, "Up", false}
                        AddIfNewBeam(beams, new_beam) end
                    if change_row < #map and (change_char == "\\" or change_char == "|") then
                        new_beam = {change_row + 1, change_col, "Down", false}
                        AddIfNewBeam(beams, new_beam) end
                elseif beams[beam_iter][3] == "Left" then
                    if change_row >= 2 and (change_char == "\\" or change_char == "|") then
                        new_beam = {change_row - 1, change_col, "Up", false}
                        AddIfNewBeam(beams, new_beam) end
                    if change_row < #map and (change_char == "/" or change_char == "|") then
                        new_beam = {change_row + 1, change_col, "Down", false}
                        AddIfNewBeam(beams, new_beam) end
                elseif beams[beam_iter][3] == "Up" then
                    if change_col >= 2 and (change_char == "\\" or change_char == "-") then
                        new_beam = {change_row, change_col - 1, "Left", false}
                        AddIfNewBeam(beams, new_beam) end
                    if change_col < #map[1] and (change_char == "/" or change_char == "-") then
                        new_beam = {change_row, change_col + 1, "Right", false}
                        AddIfNewBeam(beams, new_beam) end
                elseif beams[beam_iter][3] == "Down" then
                    if change_col >= 2 and (change_char == "/" or change_char == "-") then
                        new_beam = {change_row, change_col - 1, "Left", false}
                        AddIfNewBeam(beams, new_beam) end
                    if change_col < #map[1] and (change_char == "\\" or change_char == "-") then
                        new_beam = {change_row, change_col + 1, "Right", false}
                        AddIfNewBeam(beams, new_beam) end
                end
            end
        end
        beam_iter = beam_iter + 1
        if beam_iter > #beams then break end
    end

    local energized_map = {}
    for i=1, #map do
        energized_map[i] = {}
        for j=1, #map[1] do
            energized_map[i][j] = "."
        end
    end

    for i=1, #beams do
        local row = beams[i][1]
        local col = beams[i][2]
        local curr_char = map[row][col]
        while true do
            energized_map[row][col] = "#"
            if beams[i][3] == "Right" then
                if col <= #map[1] and curr_char ~= "|" and curr_char ~= "/" and curr_char ~= "\\" then col = col + 1
                else break end
            elseif beams[i][3] == "Left" then
                if col >= 1 and curr_char ~= "|" and curr_char ~= "/" and curr_char ~= "\\" then col = col - 1
                else break end
            elseif beams[i][3] == "Up" then
                if row >= 1 and curr_char ~= "-" and curr_char ~= "/" and curr_char ~= "\\" then row = row - 1
                else break end
            elseif beams[i][3] == "Down" then
                if row <= #map and curr_char ~= "-" and curr_char ~= "/" and curr_char ~= "\\" then row = row + 1
                else break end
            end
            if row >= 1 and row <= #map and col >= 1 and col <= #map[1] then curr_char = map[row][col] else break end
        end
    end
    --[[
    for i=1, #energized_map do
        print()
        for j=1, #energized_map[i] do
            io.write(energized_map[i][j])
        end
    end
    --]]
    local count = 0
    for i=1, #energized_map do
        for j=1, #energized_map[i] do
            if energized_map[i][j] == "#" then count = count + 1 end
        end
    end
    return count
end

local map = {}
for line in io.lines() do
    local row = {}
    for i=1, #line do
        row[i] = string.sub(line, i, i)
    end
    table.insert(map, row)
end

--[[
for i=1, #map do
    print()
    for j=1, #map[i] do
        io.write(map[i][j])
    end
end
--]]

local max = 0
for i=1, #map do
    beams = {}
    beams[1] = {i, 1, "Right", false}
    energized_count = GetEnergizedCount(map, beams)
    if energized_count > max then max = energized_count end
end
for i=1, #map do
    beams = {}
    beams[1] = {i, #map[1], "Left", false}
    energized_count = GetEnergizedCount(map, beams)
    if energized_count > max then max = energized_count end
end
for i=1, #map[1] do
    beams = {}
    beams[1] = {#map[1], i, "Up", false}
    energized_count = GetEnergizedCount(map, beams)
    if energized_count > max then max = energized_count end
end
for i=1, #map[1] do
    beams = {}
    beams[1] = {1, i, "Down", false}
    energized_count = GetEnergizedCount(map, beams)
    if energized_count > max then max = energized_count end
end
print(max)