local w = require("w")
local r = require("r")
local k = require("k")
local jua = require("jua")
local json = require("json")
local modem = peripheral.find("modem")
local await = jua.await

r.init(jua)
w.init(jua)
k.init(jua, json, w, r)


local name = "3k"
local success, address = await(k.name, name)
local owner = address.owner

if modem and modem.isWireless() then
  modem.open(123)

  jua.on("terminate", function()
    jua.stop()
    print("Terminated")
end)

jua.setInterval(function()
    local transactions = await(k.addressTransactions(owner))
    local logs = json.decodeFromFile("FloatKristLog.json")
    local lastTransactions = logs[#logs]
    local queue = {}
    
    for i, v in pairs(transactions.transactions) do
      if v.id == lastTransactions.FromId then
        break
      end
      if v.to == owner then
        queue[#queue+1] = v
      end
    end
    for i, v in pairs(queue) do
      if validate(v) then
        transfert(v)
      else
        --return the money of sender
      end
    end
  end, 1)

  print("Wired modem found at name " .. modem.getNameLocal() .. ".")
else
  print("No wired modem found.")
end



local function has_value (tab, val)
  for index, value in ipairs(tab) do
      if value == val then
          return true
      end
  end
  return false
end

local function isNumber(number)
  local values = {"0","1","2","3","4","5","6","7","8","9"}
  local topValue = false
  local point = false
  local backValue = false
  for i = 1, #number do
    char = string.sub(number, i, i)
    if has_value(values, char) then
      if point then
        backValue = true
      else
        topValue = true
    else
      if point == false and char == "." then
        point = true
      else
        return false
      end
    end
  end
  if topValue = false then
    return false
  if point and backValue = false then
    return false
  return true
end

local function isFloat(number)
  if string.find(number, ".") != nil then
    return true
  end
  return false
end

local function validate(transaction)
  local transactionData = k.parseMeta(transaction.metadata)
  -- Exemple of valid metadata: "amount=1.02;destination=nohello@switchcraft.pw"

  if transaction.name == "fk" then
    if k.parseMeta(transaction.meta.destination).name != nil then
      local before = nil
      local after = nil
      if isnumber(transaction.meta.amount) then
        return true
      else
        return false
      end
    end
  end
end

local function calculateFloat(amount1, amount2)
end

local function transfert(transaction)
  local data = json.decodeFromFile("FloatKristData.json")
  local Destination = k.parseMeta(transaction.meta.destination)
  local Return = ""
  local before = 0
  local after = 0

  if isFloat(transaction.meta.amount) then
    local values = number.split(".")
    before = values[1]
    after = values[2]
    if calculateFloat(amount1, amount2) then
      before += 1
    end
  else
    before = number
  end
  modem.transmit(123, 124, {kristAddress, amount})
  print("Sent krist transfert demand from " .. )
end

local function viewKrist(name)

end