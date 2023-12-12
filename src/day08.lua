-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day08_input_small_part1.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day08_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local instructions = io.read()
io.read()
local network = {}
for line in io.lines() do
    -- network elements will be tables of size 3 containing {position, move_left, move_right}
    table.insert(network, {string.sub(line, 1, 3), string.sub(line, 8, 10), string.sub(line, 13, 15)})
end

local steps1 = 0
local curr_pos = "AAA"
while curr_pos ~= "ZZZ" do
    steps1 = steps1 + 1
    --print(curr_pos)
    local move
    if steps1 % #instructions == 0 then
        move = string.sub(instructions, #instructions, #instructions)
    else
        move = string.sub(instructions, steps1 % #instructions, steps1 % #instructions)
    end
    for i=1, #network do
        if network[i][1] == curr_pos then
            if move == "L" then
                curr_pos = network[i][2]
            else
                curr_pos = network[i][3]
            end
            break
        end
    end
end
--print(curr_pos)

print(steps1)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day08_input_small_part2.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day08_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function GCD(a, b)
    if b ~= 0 then
        return GCD(b, a % b)
    else
        return math.abs(a)
    end
end

local function TableGCD(t)
    if #t <= 1 then return -1
    else
        local divisor = GCD(t[1], t[2])
        if #t > 2 then
            for i=3, #t do
                divisor = GCD(divisor, t[i])
            end
        return divisor
        end
    end
end

local function LCM(a, b)
    return a * b / GCD(a, b)
end

local function TableLCM(t)
    if #t < 2 then return -1
    elseif #t == 2 then return LCM(t[1], t[2])
    else
        local a = t[1]
        table.remove(t, 1)
        local b = t
        return LCM(a, TableLCM(b))
    end
end

local instructions = io.read()
io.read()
local network = {}
for line in io.lines() do
    -- network elements will be tables of size 3 containing {position, move_left, move_right}
    table.insert(network, {string.sub(line, 1, 3), string.sub(line, 8, 10), string.sub(line, 13, 15)})
end

local curr_pos = {}
for i=1, #network do
    if string.sub(network[i][1], 3, 3) == "A" then table.insert(curr_pos, network[i][1]) end
end

local cycle_lengths = {}
for i=1, #curr_pos do
    local cycle_len = 0
    while string.sub(curr_pos[i], 3, 3) ~= "Z" do
        cycle_len = cycle_len + 1
        --print(curr_pos)
        local move
        if cycle_len % #instructions == 0 then
            move = string.sub(instructions, #instructions, #instructions)
        else
            move = string.sub(instructions, cycle_len % #instructions, cycle_len % #instructions)
        end
        for j=1, #network do
            if network[j][1] == curr_pos[i] then
                if move == "L" then
                    curr_pos[i] = network[j][2]
                else
                    curr_pos[i] = network[j][3]
                end
                break
            end
        end
    end
    table.insert(cycle_lengths, cycle_len)
end

io.write("( ")
for i=1, #cycle_lengths do
    io.write(cycle_lengths[i] .. " ")
end
print(")")

local gcd = TableGCD(cycle_lengths)
print(TableLCM(cycle_lengths))

