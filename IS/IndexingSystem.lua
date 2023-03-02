local jua = require("jua")
local json = require("json")

local modem = peripheral.find("modem")

local indexFileName = "Index.json"
local indexData


local function add(itype, object, force)
    update()
    for key, value in pairs(indexData) do
        if key == itype then
            if value == indexData[key] and force == false then
                indexData[key][#indexData[key] + 1] = object
                update()
                return true
            end
        end
    end
    return false
end

local function get(itype, attribut, value)
    update()
    for a, b in pairs(indexData) do
        if a == itype then
            for c, d in ipairs(indexData[key]) do
                if d[attribut] == value then
                    return d
                end
            end
        end
    end
    return nil
end

local function remove(itype, attribut, value)
    update()
    for a, b in pairs(indexData) do
        if a == itype then
            for c, d in ipairs(indexData[key]) do
                if d[attribut] == value then
                    indexData[a][c] = {}
                    update()
                    return true
                end
            end
        end
    end
    return false
end

local function update()
    index = fs.open(indexFileName, "w")
    index.write(json.encodePretty(indexData))
    index.close()
    indexData = json.decodeFromFile(indexFileName)
end

jua.on("terminate", function ()
    jua.stop()
    print("Terminated")
end)

if modem and modem.isWireless() then
    modem.open(133)
    jua.on("modem_message", function ()
        local _, _, _, replyChannel, message = os.pullEvent("modem_message")
        if type(message) != "table" then
            modem.transmit(replyChannel, 133, {"err":"Message isn't a table"})
        elseif #message < 4 then
            modem.transmit(replyChannel, 133, {"err":"Not enough arguments"})
        elseif #message > 4 then
            modem.transmit(replyChannel, 133, {"err":"Too many arguments"})
        else
            local mode = message[1]

            local value1 = message[2]
            local value2 = message[3]
            local value3 = message[4]

            if mode == "get" then
                get(value1,value2,value3)
            elseif mode == "rm" then
                remove(value1,value2,value3)
            elseif mode == "add" then   
                add(value1,value2,value3)
            else
                modem.transmit(replyChannel, 133, {"err":"Invalid mode was specified"})
            end
        end
    end) 
else 
    print("No wired modem found.")
end