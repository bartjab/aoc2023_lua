-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day15_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day15_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local input = io.read()
local curr_char = 1
local hash_sum = 0
while curr_char <= #input do
    local sep = string.find(input, ",", curr_char)
    local str_hash = 0
    if sep ~= nil then
        for i=curr_char, sep-1 do
            str_hash = ((str_hash + string.byte(string.sub(input, i, i))) * 17) % 256
        end
    else
        for i=curr_char, #input do
            str_hash = ((str_hash + string.byte(string.sub(input, i, i))) * 17) % 256
        end
        hash_sum = hash_sum + str_hash
        break
    end
    hash_sum = hash_sum + str_hash
    curr_char = sep + 1
end
print(hash_sum)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day15_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day15_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function InsertLens(t, str)
    local sep = string.find(str, "=")
    local lens_name = string.sub(str, 1, sep-1)
    local focal_length = string.sub(str, sep+1, #str)
    local lens = {lens_name, focal_length}
    local str_hash = 0

    for i=1, #lens_name do
        str_hash = ((str_hash + string.byte(string.sub(lens_name, i, i))) * 17) % 256
    end

    local isNameOccurs = false
    local same_name_pos
    if t[str_hash+1] == nil then
        t[str_hash+1] = {}
        t[str_hash+1][1] = lens
    else
        for i=1, #t[str_hash+1] do
            if t[str_hash+1][i][1] == lens_name then
                isNameOccurs = true
                same_name_pos = i
                break
            end
        end
        if isNameOccurs then
            t[str_hash+1][same_name_pos][2] = focal_length
        else
            table.insert(t[str_hash+1], lens)
        end
    end
end

local function RemoveLens(t, str)
    local str_hash = 0
    local lens_name = string.sub(str, 1, #str-1)
    for i=1, #lens_name do
        str_hash = ((str_hash + string.byte(string.sub(lens_name, i, i))) * 17) % 256
    end

    if t ~= nil then
        if t[str_hash+1] ~= nil then
            for i=1, #t[str_hash+1] do
                if lens_name == t[str_hash+1][i][1] then table.remove(t[str_hash+1], i) break end
            end
        end
    end
end


local input = io.read()

local boxes = {}
local curr_char = 1
while curr_char <= #input do
    local sep = string.find(input, ",", curr_char)
    if sep == nil then
        sep = #input + 1
    end

    local operation = string.sub(input, curr_char, sep-1)
    local oper_check = string.find(operation, "=")
    if oper_check ~= nil then InsertLens(boxes, operation)
    else RemoveLens(boxes, operation) end

    if sep == #input + 1 then
        break
    else
        curr_char = sep + 1
    end
end

--[[
for i=1, 256 do
    io.write("Box " .. i-1 .. ":")
    if boxes[i] == nil then io.write(" ")
    else
        for j=1, #boxes[i] do
            io.write("[" .. boxes[i][j][1] .. " " .. boxes[i][j][2] .. "]")
        end
    end
    print()
end
]]--

local total_power = 0
for i=1, 256 do
    if boxes[i] ~= nil then
        for j=1, #boxes[i] do
            total_power = total_power + i * j * boxes[i][j][2] -- total_power += focusing_power for each lens
        end
    end
end
print(total_power)