-- PART 1

-- INPUT READING
if small_input then
    local input_file = io.open("day07_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day07_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function CountCards(hand)
    if #hand ~= 5 then return -1
    else
        local cards = {}
        table.insert(cards, {string.sub(hand, 1, 1), 1})
        for i=2, #hand do
            local is_new_card = true
            for j=1, #cards do
                if string.sub(hand, i, i) == cards[j][1] then
                    is_new_card = false
                    cards[j][2] = cards[j][2] + 1
                end
            end
            if is_new_card then table.insert(cards, {string.sub(hand, i, i), 1}) end
        end
        return cards
    end
end

local function SortHandBids(t)
    local priority = {"A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"}
    local hands = {}
    if #t >= 2 then
        for i=1, #t do
            table.insert(hands, t[i][1])
        end
        for i=1, #hands - 1 do
            for j=i+1, #hands do
                local priority_val1 = 0
                local priority_val2 = 0
                for char=1, #hands[i] do
                    for x=1, #priority do
                        if string.sub(hands[i], char, char) == priority[x] then priority_val1 = x end
                        if string.sub(hands[j], char, char) == priority[x] then priority_val2 = x end
                    end
                    if priority_val2 > priority_val1 then
                        local temp = hands[i]
                        hands[i] = hands[j]
                        hands[j] = temp
                        break
                    elseif priority_val2 < priority_val1 then
                        break
                    end
                end
            end
        end
        for i=1, #hands do
            for j=1, #t do
                if hands[i] == t[j][1] then hands[i] = j break end
            end
        end
        local sorted_t = {}
        for i=1, #hands do
            table.insert(sorted_t, {t[hands[i]][1], t[hands[i]][2]})
        end

        for i=1, #sorted_t do
            t[i][1] = sorted_t[i][1]
            t[i][2] = sorted_t[i][2]
        end
    end
end

--[[
local function ShowCards(cards)
    io.write("( ")
    for i=1, #cards do
        io.write(cards[i][1] .. "x" .. cards[i][2] .. " ")
    end
    io.write(")")
    print()
end
--]]

local hand_bids = {}
local types = {{{0, 0}}, {{0, 0}}, {{0, 0}}, {{0, 0}}, {{0, 0}}, {{0, 0}}, {{0, 0}}} -- high card, pair, two pairs, three of a kind, full house, four of a kind, five of a kind
for line in io.lines() do
    local space = string.find(line, " ")
    table.insert(hand_bids, {string.sub(line, 1, space - 1), tonumber(string.sub(line, space + 1, #line))})
end

for i = 1, #hand_bids do
    local hand = CountCards(hand_bids[i][1])
    local hand_type = 0
    if hand[1][2] == 5 then --five of a kind
        hand_type = 7
    elseif hand[1][2] == 4 or hand[2][2] == 4 then --four of a kind
        hand_type = 6
    elseif (hand[1][2] == 3 and hand[2][2] == 2) or (hand[1][2] == 2 and hand[2][2] == 3) then --full house
        hand_type = 5
    elseif hand[1][2] == 3 or hand[2][2] == 3 or hand[3][2] == 3 then --three of a kind
        hand_type = 4
    else
        while hand ~= nil do
            if hand[1][2] == 2 then
                table.remove(hand, 1)
                if #hand == 3 then hand_type = 2
                elseif #hand == 2 then
                    if hand[1][2] == 2 or hand[2][2] == 2 then
                        hand_type = 3
                    else
                        hand_type = 2
                    end
                elseif #hand == 1 then
                    if hand[1][2] == 2 then
                        hand_type = 3
                    else
                        hand_type = 2
                    end
                else
                    hand_type = 2
                end
                break
            else
                table.remove(hand, 1)
                if #hand == 0 then hand_type = 1 break end
            end
        end
    end
    if types[hand_type][1][1] == 0 and types[hand_type][1][2] == 0 then
        types[hand_type][1][1] = hand_bids[i][1]
        types[hand_type][1][2] = hand_bids[i][2]
    else
        table.insert(types[hand_type], hand_bids[i])
    end
end

local iter = 0
local result1 = 0
for type=1, #types do
    SortHandBids(types[type])
    for i=1, #types[type] do
        if types[type][i][1] ~= 0 then
            iter = iter + 1
            --print(types[type][i][2])
            result1 = result1 + (types[type][i][2] * iter)
        else break
        end
    end
end

--[[
for type=1, #types do
    print("Type " .. type ..":")
    for i=1, #types[type] do
        if types[type][1][1] == 0 then print() break
        else
            print(types[type][i][1] .. " " .. types[type][i][2])
        end
    end
end
]]--

print(result1)
io.close()

-- PART 2

-- INPUT READING
if small_input then
    local input_file = io.open("day07_input_small.txt", r)
    io.input(input_file)
else
    local input_file = io.open("day07_input_large.txt", r)
    io.input(input_file)
end

-- PROBLEM IMPLEMENTATION BEGINS HERE

local function CountCardsJoker(hand)
    if #hand ~= 5 then return -1
    else
        local cards = {}
        table.insert(cards, {string.sub(hand, 1, 1), 1})
        for i=2, #hand do
            local is_new_card = true
            for j=1, #cards do
                if string.sub(hand, i, i) == cards[j][1] then
                    is_new_card = false
                    cards[j][2] = cards[j][2] + 1
                end
            end
            if is_new_card then table.insert(cards, {string.sub(hand, i, i), 1}) end
        end
        local jokers = 0
        local jokers_pos = 0
        for i=1, #cards do
            if cards[i][1] == "J" then
                jokers = cards[i][2]
                jokers_pos = i
                break
            end
        end
        if jokers < 5 and jokers > 0 then
            table.remove(cards, jokers_pos)
            local repeats_max = 0
            local repeats_max_pos = 0
            for i=1, #cards do
                if cards[i][2] > repeats_max then
                    repeats_max = cards[i][2]
                    repeats_max_pos = i
                end
            end
            cards[repeats_max_pos][2] = cards[repeats_max_pos][2] + jokers
        end
        return cards
    end
end

local function SortHandBidsJoker(t)
    local priority = {"A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"}
    local hands = {}
    if #t >= 2 then
        for i=1, #t do
            table.insert(hands, t[i][1])
        end
        for i=1, #hands - 1 do
            for j=i+1, #hands do
                local priority_val1 = 0
                local priority_val2 = 0
                for char=1, #hands[i] do
                    for x=1, #priority do
                        if string.sub(hands[i], char, char) == priority[x] then priority_val1 = x end
                        if string.sub(hands[j], char, char) == priority[x] then priority_val2 = x end
                    end
                    if priority_val2 > priority_val1 then
                        local temp = hands[i]
                        hands[i] = hands[j]
                        hands[j] = temp
                        break
                    elseif priority_val2 < priority_val1 then
                        break
                    end
                end
            end
        end
        for i=1, #hands do
            for j=1, #t do
                if hands[i] == t[j][1] then hands[i] = j break end
            end
        end
        local sorted_t = {}
        for i=1, #hands do
            table.insert(sorted_t, {t[hands[i]][1], t[hands[i]][2]})
        end

        for i=1, #sorted_t do
            t[i][1] = sorted_t[i][1]
            t[i][2] = sorted_t[i][2]
        end
    end
end

--[[
local function ShowCards(cards)
    io.write("( ")
    for i=1, #cards do
        io.write(cards[i][1] .. "x" .. cards[i][2] .. " ")
    end
    io.write(")")
    print()
end
--]]

local hand_bids = {}
local types = {{{0, 0}}, {{0, 0}}, {{0, 0}}, {{0, 0}}, {{0, 0}}, {{0, 0}}, {{0, 0}}} -- high card, pair, two pairs, three of a kind, full house, four of a kind, five of a kind
for line in io.lines() do
    local space = string.find(line, " ")
    table.insert(hand_bids, {string.sub(line, 1, space - 1), tonumber(string.sub(line, space + 1, #line))})
end

for i = 1, #hand_bids do
    local hand = CountCardsJoker(hand_bids[i][1])
    local hand_type = 0
    if hand[1][2] == 5 then --five of a kind
        hand_type = 7
    elseif hand[1][2] == 4 or hand[2][2] == 4 then --four of a kind
        hand_type = 6
    elseif (hand[1][2] == 3 and hand[2][2] == 2) or (hand[1][2] == 2 and hand[2][2] == 3) then --full house
        hand_type = 5
    elseif hand[1][2] == 3 or hand[2][2] == 3 or hand[3][2] == 3 then --three of a kind
        hand_type = 4
    else
        while hand ~= nil do
            if hand[1][2] == 2 then
                table.remove(hand, 1)
                if #hand == 3 then hand_type = 2
                elseif #hand == 2 then
                    if hand[1][2] == 2 or hand[2][2] == 2 then
                        hand_type = 3
                    else
                        hand_type = 2
                    end
                elseif #hand == 1 then
                    if hand[1][2] == 2 then
                        hand_type = 3
                    else
                        hand_type = 2
                    end
                else
                    hand_type = 2
                end
                break
            else
                table.remove(hand, 1)
                if #hand == 0 then hand_type = 1 break end
            end
        end
    end
    if types[hand_type][1][1] == 0 and types[hand_type][1][2] == 0 then
        types[hand_type][1][1] = hand_bids[i][1]
        types[hand_type][1][2] = hand_bids[i][2]
    else
        table.insert(types[hand_type], hand_bids[i])
    end
end

local iter = 0
local result2 = 0
for type=1, #types do
    SortHandBidsJoker(types[type])
    for i=1, #types[type] do
        if types[type][i][1] ~= 0 then
            iter = iter + 1
            --print(types[type][i][2])
            result2 = result2 + (types[type][i][2] * iter)
        else break
        end
    end
end

--[[
for type=1, #types do
    print("Type " .. type ..":")
    for i=1, #types[type] do
        if types[type][1][1] == 0 then print() break
        else
            print(types[type][i][1] .. " " .. types[type][i][2])
        end
    end
end
]]--

print(result2)
io.close()