-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day04_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day04_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local total_points = 0

for line in io.lines() do
    local colon_pos = string.find(line, ":")
    local vbar_pos = string.find(line, "|")
    local curr_char_pos = colon_pos + 1
    local winning_nums = {}
    local typed_nums = {}
    while curr_char_pos <= vbar_pos - 2 do
        local i, j = string.find(line, "%d+", curr_char_pos)
        table.insert(winning_nums, tonumber(string.sub(line, i, j)))
        curr_char_pos = j+1
    end
    while curr_char_pos <= #line do
        local i, j = string.find(line, "%d+", curr_char_pos)
        table.insert(typed_nums, tonumber(string.sub(line, i, j)))
        curr_char_pos = j+1
    end
    table.sort(winning_nums)
    table.sort(typed_nums)
    local winning_nums_count = 0
    local win_table_pos = 1
    local typed_table_pos = 1
    while win_table_pos <= #winning_nums and typed_table_pos <= #typed_nums do
        if typed_nums[typed_table_pos] < winning_nums[win_table_pos] then
            typed_table_pos = typed_table_pos + 1
        elseif typed_nums[typed_table_pos] == winning_nums[win_table_pos] then
            -- io.write(winning_nums[win_table_pos] .. " ")
            winning_nums_count = winning_nums_count + 1
            typed_table_pos = typed_table_pos + 1
            win_table_pos = win_table_pos + 1
        elseif typed_nums[typed_table_pos] > winning_nums[win_table_pos] then
            win_table_pos = win_table_pos + 1
        end
    end
    if winning_nums_count >= 1 then
        total_points = total_points + 2^(winning_nums_count - 1)
    end
end

print(total_points)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day04_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day04_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local total_cards = 0
local card_instances = {}
local current_original_card = 1

for line in io.lines() do
    if card_instances[current_original_card] == nil then
        table.insert(card_instances, current_original_card, 1)
    else
        card_instances[current_original_card] = card_instances[current_original_card] + 1
    end
    local colon_pos = string.find(line, ":")
    local vbar_pos = string.find(line, "|")
    local curr_char_pos = colon_pos + 1
    local winning_nums = {}
    local typed_nums = {}
    while curr_char_pos <= vbar_pos - 2 do
        local i, j = string.find(line, "%d+", curr_char_pos)
        table.insert(winning_nums, tonumber(string.sub(line, i, j)))
        curr_char_pos = j+1
    end
    while curr_char_pos <= #line do
        local i, j = string.find(line, "%d+", curr_char_pos)
        table.insert(typed_nums, tonumber(string.sub(line, i, j)))
        curr_char_pos = j+1
    end
    table.sort(winning_nums)
    table.sort(typed_nums)
    local winning_nums_amount = 0
    local win_table_pos = 1
    local typed_table_pos = 1
    while win_table_pos <= #winning_nums and typed_table_pos <= #typed_nums do
        if typed_nums[typed_table_pos] < winning_nums[win_table_pos] then
            typed_table_pos = typed_table_pos + 1
        elseif typed_nums[typed_table_pos] == winning_nums[win_table_pos] then
            -- io.write(winning_nums[win_table_pos] .. " ")
            winning_nums_amount = winning_nums_amount + 1
            if card_instances[current_original_card + winning_nums_amount] == nil then
                table.insert(card_instances, current_original_card + winning_nums_amount, card_instances[current_original_card])
            else
                card_instances[current_original_card + winning_nums_amount] = card_instances[current_original_card + winning_nums_amount] + card_instances[current_original_card]
            end
            typed_table_pos = typed_table_pos + 1
            win_table_pos = win_table_pos + 1
        elseif typed_nums[typed_table_pos] > winning_nums[win_table_pos] then
            win_table_pos = win_table_pos + 1
        end
    end
    current_original_card = current_original_card + 1
end

for i=1, #card_instances do
    --io.write(card_instances[i].." ")
    total_cards = total_cards + card_instances[i]
end
--print()

print(total_cards)
io.close()