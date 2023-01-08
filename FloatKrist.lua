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
    transactions = await(addressTransactions(owner))
    lastTransactions = 
    for i = transactions.transactions do

    end
  end, 1
)

local function viewKrist(name):

end