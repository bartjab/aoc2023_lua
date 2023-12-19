-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day14_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day14_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local platform = {}
for line in io.lines() do
    local chars = {}
    for i=1, #line do
        chars[i] = string.sub(line, i, i)
    end
    table.insert(platform, chars)
end
--[[
for i=1, #platform do
    for j=1, #platform[i] do
        io.write(platform[i][j])
    end
    print()
end
--]]
for j=1, #platform[1] do
    local round_rock_count = 0
    local change_begin = 1
    for i=1, #platform do
        if platform[i][j] == "O" then round_rock_count = round_rock_count + 1
        elseif platform[i][j] == "#" then
            if i - change_begin > 0 then
                for k=change_begin, i-1 do
                    if round_rock_count > 0 then
                        platform[k][j] = "O"
                        round_rock_count = round_rock_count - 1
                    else
                        platform[k][j] = "."
                    end
                end
            end
            change_begin = i+1
        end
        if i == #platform then
            for k=change_begin, i do
                if round_rock_count > 0 then
                    platform[k][j] = "O"
                    round_rock_count = round_rock_count - 1
                else
                    platform[k][j] = "."
                end
            end
        end
    end
end
--[[
print()
for i=1, #platform do
    for j=1, #platform[i] do
        io.write(platform[i][j])
    end
    print()
end
--]]
local load_sum = 0
for i=1, #platform do
    for j=1, #platform[1] do
        if platform[i][j] == "O" then load_sum = load_sum + #platform - i + 1 end
    end
end
print(load_sum)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day14_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day14_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function TiltNorth(t)
    for j=1, #t[1] do
        local round_rock_count = 0
        local change_begin = 1
        for i=1, #t do
            if t[i][j] == "O" then round_rock_count = round_rock_count + 1
            elseif t[i][j] == "#" then
                if i - change_begin > 0 then
                    for k=change_begin, i-1 do
                        if round_rock_count > 0 then
                            t[k][j] = "O"
                            round_rock_count = round_rock_count - 1
                        else
                            t[k][j] = "."
                        end
                    end
                end
                change_begin = i+1
            end
            if i == #t then
                for k=change_begin, i do
                    if round_rock_count > 0 then
                        t[k][j] = "O"
                        round_rock_count = round_rock_count - 1
                    else
                        t[k][j] = "."
                    end
                end
            end
        end
    end
end

local function TiltSouth(t)
    for j=1, #t[1] do
        local round_rock_count = 0
        local change_begin = #t
        for i=#t, 1, -1 do
            if t[i][j] == "O" then round_rock_count = round_rock_count + 1
            elseif t[i][j] == "#" then
                if change_begin - i > 0 then
                    for k=change_begin, i+1, -1 do
                        if round_rock_count > 0 then
                            t[k][j] = "O"
                            round_rock_count = round_rock_count - 1
                        else
                            t[k][j] = "."
                        end
                    end
                end
                change_begin = i-1
            end
            if i == 1 then
                for k=change_begin, 1, -1 do
                    if round_rock_count > 0 then
                        t[k][j] = "O"
                        round_rock_count = round_rock_count - 1
                    else
                        t[k][j] = "."
                    end
                end
            end
        end
    end
end

local function TiltEast(t)
    for i=1, #t do
        local round_rock_count = 0
        local change_begin = #t
        for j=#t[1], 1, -1 do
            if t[i][j] == "O" then round_rock_count = round_rock_count + 1
            elseif t[i][j] == "#" then
                if change_begin - j > 0 then
                    for k=change_begin, j+1, -1 do
                        if round_rock_count > 0 then
                            t[i][k] = "O"
                            round_rock_count = round_rock_count - 1
                        else
                            t[i][k] = "."
                        end
                    end
                end
                change_begin = j-1
            end
            if j == 1 then
                for k=change_begin, 1, -1 do
                    if round_rock_count > 0 then
                        t[i][k] = "O"
                        round_rock_count = round_rock_count - 1
                    else
                        t[i][k] = "."
                    end
                end
            end
        end
    end
end

local function TiltWest(t)
    for i=1, #t do
        local round_rock_count = 0
        local change_begin = 1
        for j=1, #t[1] do
            if t[i][j] == "O" then round_rock_count = round_rock_count + 1
            elseif t[i][j] == "#" then
                if j - change_begin > 0 then
                    for k=change_begin, j-1 do
                        if round_rock_count > 0 then
                            t[i][k] = "O"
                            round_rock_count = round_rock_count - 1
                        else
                            t[i][k] = "."
                        end
                    end
                end
                change_begin = j+1
            end
            if j == #t[1] then
                for k=change_begin, j do
                    if round_rock_count > 0 then
                        t[i][k] = "O"
                        round_rock_count = round_rock_count - 1
                    else
                        t[i][k] = "."
                    end
                end
            end
        end
    end
end

local platform = {}
for line in io.lines() do
    local chars = {}
    for i=1, #line do
        chars[i] = string.sub(line, i, i)
    end
    table.insert(platform, chars)
end
--[[
for i=1, #platform do
    for j=1, #platform[i] do
        io.write(platform[i][j])
    end
    print()
end
print()
--]]
local spins = {}
local cycle_begin
local cycle_end
for spin=1, 1000000000 do
    TiltNorth(platform)
    TiltWest(platform)
    TiltSouth(platform)
    TiltEast(platform)

    local record = ""
    for i=1, #platform do
        for j=1, #platform[i] do
            record = record .. platform[i][j]
        end
    end

    local isSameState = false

    if #spins > 0 then
        for c=1, #spins do
            if record == spins[c] then
                isSameState = true
                cycle_begin = c break
            end
        end
    end
    if #spins > 0 and isSameState then
        table.insert(spins, record)
        cycle_end = spin
        break
    end
    table.insert(spins, record)
end

--print(cycle_begin .. " " .. cycle_end)

local cycle = {}
for i=cycle_begin, cycle_end do
    cycle[i - cycle_begin + 1] = spins[i]
end
--[[
for i=1, #cycle do
    print(cycle[i])
end
--]]
local end_state_pos = (1000000000 - cycle_begin) % (#cycle - 1) + 1

local end_state = {}
for i=1, #platform do
    end_state[i] = {}
    for j=1, #platform[1] do
        end_state[i][j] = string.sub(cycle[end_state_pos], (i-1)*#platform[1] + j, (i-1)*#platform[1] + j)
    end
end

local load_sum = 0
for i=1, #end_state do
    for j=1, #end_state[1] do
        if end_state[i][j] == "O" then load_sum = load_sum + #end_state - i + 1 end
    end
end
print(load_sum)
