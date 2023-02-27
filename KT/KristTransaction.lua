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

local ws

local file = fs.open("PrivateKey", "r")
local key = file.readAll()
file.close()

jua.on("terminate", function()
  jua.stop()
  print("Terminated")
end)


if modem and modem.isWireless() then
  modem.open(124)
  
  jua.on("modem_message", function()
      local event, _, sender, _, message = os.pullEvent("modem_message")
      local kristAddress = message[1]
      local amount = message[2]
      local success, data = k.send(privateKey, kristAddress, amount)
      if success then
          print("Sent " .. amount .. " KRIST to address " .. kristAddress)
      else
          print("Transaction failed: " .. json.encode(data))
      end
  end)
  
  jua.go(
  function()
    local name = "3k"
    local success, address = await(k.name, name)
    local owner = address.owner
    local success, b = await(k.address, owner)
    local balance = b.balance
    if success then
      print("Adresse: "..owner.." ("..name..".kst)")
      print("Balance: "..balance.." kst")
    end
    print("Wired modem found at name " .. modem.getNameLocal() .. ".")
  end)
else
  print("No wired modem found.")
end