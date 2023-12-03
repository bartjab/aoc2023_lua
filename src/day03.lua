-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day03_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day03_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function GetLineAlignedPartsSum(line, special_pos, is_current)
    local line_part_sum = 0
    local curr_char = 1
    if is_current == false then
        while true do
            local k, l = string.find(line, "%d+", curr_char)
            if k ~= nil then
                if (special_pos >= k and special_pos <= l) or special_pos == l+1 or special_pos == k-1 then
                    line_part_sum = line_part_sum + tonumber(string.sub(line, k, l))
                end
                curr_char = l+1
            else break
            end
        end
    else
        while true do
            local k, l = string.find(line, "%d+", curr_char)
            if k ~= nil then
                if special_pos == l+1 or special_pos == k-1 then
                    line_part_sum = line_part_sum + tonumber(string.sub(line, k, l))
                end
                curr_char = l+1
            else break
            end
        end
    end
    return line_part_sum
end

local part_sum = 0
local previous_line = nil
local current_line = nil
local next_line = nil

for line in io.lines() do
    if current_line ~= nil then previous_line = string.sub(current_line, 1, string.len(current_line)) end
    if next_line ~= nil then current_line = string.sub(next_line, 1, string.len(next_line)) end
    next_line = string.sub(line, 1, string.len(line))
    if current_line ~= nil then
        for i=1, #current_line do
            if string.sub(current_line, i, i) ~= "%d" and string.sub(current_line,i ,i) ~= "." then
                part_sum = part_sum + GetLineAlignedPartsSum(current_line, i, true)
                part_sum = part_sum + GetLineAlignedPartsSum(next_line, i, false)
                if previous_line ~= nil then
                    part_sum = part_sum + GetLineAlignedPartsSum(previous_line, i, false)
                    --print(GetLineAlignedPartsSum(current_line, i, true), GetLineAlignedPartsSum(next_line, i, false), GetLineAlignedPartsSum(previous_line, i, false))
                end
            end
        end
    end
end

print(part_sum)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day03_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day03_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function GetValidGearRatio(p_line, c_line, n_line, special_pos)
    local part_count = 0
    local parts = {}
    local curr_char = 1
    if p_line ~= nil then
        while true do
            local k, l = string.find(p_line, "%d+", curr_char)
            if k ~= nil then
                if (special_pos >= k and special_pos <= l) or special_pos == l+1 or special_pos == k-1 then
                    part_count = part_count + 1
                    table.insert(parts, tonumber(string.sub(p_line, k, l)))
                end
                curr_char = l+1
            else break
            end
        end
    end
    curr_char = 1
    while true do
        local k, l = string.find(c_line, "%d+", curr_char)
        if k ~= nil then
            if special_pos == l+1 or special_pos == k-1 then
                part_count = part_count + 1
                table.insert(parts, tonumber(string.sub(c_line, k, l)))
            end
            curr_char = l+1
        else break
        end
    end
    curr_char = 1
    while true do
        local k, l = string.find(n_line, "%d+", curr_char)
        if k ~= nil then
            if (special_pos >= k and special_pos <= l) or special_pos == l+1 or special_pos == k-1 then
                part_count = part_count + 1
                table.insert(parts, tonumber(string.sub(n_line, k, l)))
            end
            curr_char = l+1
        else break
        end
    end
    if part_count == 2 then return parts[1]*parts[2] else return 0 end
end

previous_line = nil
current_line = nil
next_line = nil
local gear_ratio_sum = 0

for line in io.lines() do
    if current_line ~= nil then previous_line = string.sub(current_line, 1, string.len(current_line)) end
    if next_line ~= nil then current_line = string.sub(next_line, 1, string.len(next_line)) end
    next_line = string.sub(line, 1, string.len(line))
    if current_line ~= nil then
        for i=1, #current_line do
            if string.sub(current_line, i, i) == "*" then
                gear_ratio_sum = gear_ratio_sum + GetValidGearRatio(previous_line, current_line, next_line, i)
            end
        end
    end

end

print(gear_ratio_sum)
