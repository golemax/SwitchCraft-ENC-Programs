local jua = require("jua")
local json = require("json")

local modem = peripheral.find("modem")

local indexFileName = "Index.json"
local indexData


local function add(itype, object)
    update()
    for key, value in pairs(indexData) do
        if key == itype then
            indexData[key][#indexData[key] + 1] = object
            update()
            return true
        end
    end
    return false
end

local function get(itype, attribut, value)
    update()
    for key, value in pairs(indexData) do
        if key == itype then
            for i=1, #indexData[key] do
                if indexData[key][i][attribut] == value then
                    return indexData[key][i]
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
    if indexData ~= nil then
        index = fs.open(indexFileName, "w")
        index.write(json.encodePretty(indexData))
        index.close()
    end
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
        elseif #message < 1 then
            modem.transmit(replyChannel, 133, {"err":"Not enough arguments"})
        else
            local mode = message[1]

            local itype = message[2]
            local attribut = message[3]
            local value = message[4]

            if mode == "get" then
                if #message < 4 then
                    modem.transmit(replyChannel, 133, {"err":"Not enough arguments"})
                elseif #message > 4 then
                    modem.transmit(replyChannel, 133, {"err":"Too many arguments"})
                else
                    get(itype,attribut,value)
                end
            elseif mode == "rm" then
                if #message < 4 then
                    modem.transmit(replyChannel, 133, {"err":"Not enough arguments"})
                elseif #message > 4 then
                    modem.transmit(replyChannel, 133, {"err":"Too many arguments"})
                else
                    remove(itype,attribut,value)
                end
            elseif mode == "add" then
                if #message < 3 then
                    modem.transmit(replyChannel, 133, {"err":"Not enough arguments"})
                elseif #message > 3 then
                    modem.transmit(replyChannel, 133, {"err":"Too many arguments"})
                else
                    add(itype,attribut)
                end
            else
                modem.transmit(replyChannel, 133, {"err":"Invalid mode was specified"})
            end
        end
    end) 
else 
    print("No wired modem found.")
end
