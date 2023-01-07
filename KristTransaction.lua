local w = require("w")
local r = require("r")
local k = require("k")
local jua = require("jua")
os.loadAPI(fs.exists("json.lua") and "json.lua" or "json")
local json = _G.json
_G.json = nil
local await = jua.await

r.init(jua)
w.init(jua)
k.init(jua, json, w, r)

local ws

local file = fs.open("PrivateKey", "r")
local key = file.readAll()
file.close()

jua.on("terminate", function()
  jua.stop()
  print("Terminated")
end)

jua.go(
  function()
    local name = "3k"
    local success, address = await(k.name, name)
    local success, b = await(k.address, address.owner)
    local owner = address.owner
    local balance = b.balance
    if success then
      print("Adresse: "..owner.." ("..name..".kst)")
      print("Balance: "..balance.." kst")
    end
    jua.stop()
  end
)
