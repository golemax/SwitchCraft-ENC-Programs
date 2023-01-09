local w = require("w")
local r = require("r")
local k = require("k")
local jua = require("jua")
local json = require("json")
local await = jua.await

r.init(jua)
w.init(jua)
k.init(jua, json, w, r)


local name = "3k"
local success, address = await(k.name, name)
local owner = address.owner

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
      transfert(v)
    end
  end, 1
)

local function transfert(transaction)
  local data = json.decodeFromFile("FloatKristData.json")
  if transaction.send_metaname == "fk" then
    
  end
end

local function viewKrist(name)

end