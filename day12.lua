-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day12_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day12_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local count = 0
local function CountArrangements(spr, damages)
    local q = string.find(spr, "?")
    if q ~= nil then
        local new_springs_w_oper = string.gsub(spr, "?", ".", 1)
        local new_springs_w_dam = string.gsub(spr, "?", "#", 1)
        CountArrangements(new_springs_w_oper, damages)
        CountArrangements(new_springs_w_dam, damages)
    else
        local isArrangement = true
        local curr_char = 1
        local curr_dam_rec = 1
        while curr_char <= #spr and curr_dam_rec <= #damages do
            local i, j = string.find(spr, "[#]+", curr_char)
            local pattern
            if i ~= nil then
                pattern = string.sub(spr, i, j)
            else
                isArrangement = false
                break
            end
            if pattern ~= nil and #pattern == damages[curr_dam_rec] then
                curr_char = j+1
                curr_dam_rec = curr_dam_rec + 1
                if curr_char <= #spr and curr_dam_rec > #damages then
                    local check = string.find(spr, "[#]", curr_char)
                    if check ~= nil then isArrangement = false break end
                end
                if curr_char > #spr and curr_dam_rec <= #damages then
                    isArrangement = false
                    break
                end
            else
                isArrangement = false
                break
            end

        end
        --print(isArrangement)
        if isArrangement then count = count + 1 end
    end
end

local arrangements_sum = 0
for line in io.lines() do
    local sep = string.find(line, "%s")
    local springs = string.sub(line, 1, sep-1)
    local damage_records = {}
    local char = sep + 1
    while char <= #line do
        local i, j = string.find(line, "%d+", char)
        table.insert(damage_records, tonumber(string.sub(line, i, j)))
        char = j+1
    end
    CountArrangements(springs, damage_records, 0)
    arrangements_sum = arrangements_sum + count
    count = 0
end
print(arrangements_sum)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day12_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day12_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local total_count = 0

for line in io.lines() do
    local sep = string.find(line, "%s")
    local springs = string.sub(line, 1, sep-1)
    local damage_records = {}
    local char = sep + 1
    while char <= #line do
        local i, j = string.find(line, "%d+", char)
        table.insert(damage_records, tonumber(string.sub(line, i, j)))
        char = j+1
    end
    local dmg_copy_len = #damage_records
    for i=1, 4 do
        springs = springs .. "?" .. string.sub(line, 1, sep-1)
        for j=1, dmg_copy_len do
            table.insert(damage_records, damage_records[j])
        end
    end

    local dp = {}
    local ways_dot
    local ways_hash
    springs = springs .. "."
    table.insert(damage_records, 0)

    for i=1, #springs do
        dp[i] = {}
        for j=1, #damage_records do
            dp[i][j] = {}
            for k=1, damage_records[j] + 1 do
                dp[i][j][k] = 0
            end
        end
    end

    for i=1, #springs do
        local curr_char = string.sub(springs, i, i)
        for j=1, #damage_records do
            for k=0, damage_records[j] do
                if i == 1 then
                    if j ~= 1 then
                        dp[i][j][k+1] = 0
                    elseif curr_char == "#" then
                        if k ~= 1 then
                            dp[i][j][k+1] = 0
                        else
                            dp[i][j][k+1] = 1
                        end
                    elseif curr_char == "." then
                        if k ~= 0 then
                            dp[i][j][k+1] = 0
                        else
                            dp[i][j][k+1] = 1
                        end
                    elseif curr_char == "?" then
                        if k > 1 then
                            dp[i][j][k+1] = 0
                        else
                            dp[i][j][k+1] = 1
                        end
                    end
                else
                    -- curr_char is .
                    if k ~= 0 then
                        ways_dot = 0
                    elseif j > 1 then
                        ways_dot = dp[i-1][j-1][damage_records[j-1] + 1]
                        ways_dot = ways_dot + dp[i-1][j][1]
                    else
                        if string.find(string.sub(line, 1, i), "#") == nil then
                            ways_dot = 1
                        else
                            ways_dot = 0
                        end
                    end

                    --curr_char is #
                    if k == 0 then
                        ways_hash = 0
                    else
                        ways_hash = dp[i-1][j][k]
                    end

                    if curr_char == "." then
                        dp[i][j][k+1] = ways_dot
                    elseif curr_char == "#" then
                        dp[i][j][k+1] = ways_hash
                    else
                        dp[i][j][k+1] = ways_dot + ways_hash
                    end
                end
            end
        end
    end
    total_count = total_count + dp[#springs][#damage_records][1]
end

print(total_count)