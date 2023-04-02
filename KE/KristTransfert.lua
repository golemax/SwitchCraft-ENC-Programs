local modem = peripheral.find("modem") or error("No modem attached", 0)

KristTransactionPort = 2533

modem.open(DefaultPort)

alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
idLenght = 6
maxIdValue = math.pow(string.len(alphabet), idLenght)

local function mixed(text,key)
    
    index=0
    for i = 1, string.len(text) do
        while index >= string.len(key) do
            index = index - string.len(key)
        end
        decal = string.find(key[index])
        while decal >= string.len(alphabet) do
            decal = decal - string.len(alphabet)
        end
        temp=text[decal]
        text[decal] = text[i]
        text[i]=temp
    end
    return text
end

local function cesar(text,word)
    index=0
    for i = 1, string.len(text) do
        while index >= string.len(word) do
            index = index - string.len(word)
        end
        decal = string.find(text[i]) + string.find(word[index])
        while decal >= string.len(alphabet) do
            decal = decal - string.len(alphabet)
        end
        text[i] = alphabet[decal]
    end
    return text
end

local function tobinary(text, alphabet):
    result = []
    for i = 1, string.len(text) do
        for j = 1, string.len(alphabet) do
            if text[i] == text[j] then
                result[]
            end
        end
    end
end

local function encode(number,key, word)
    --binary = tobinary(number)
    text = mixed(binary, "CVTHBUK")
    --text = totext(binary)
    text = cesar(text, "ZSEDRFT")
end

while true do
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")

  modem.open(replyChannel)

  --generate id pair and give it

  if replyChannel ~= DefaultPort then
    modem.close(replyChannel)
  end
end

print("Received a reply: " .. tostring(message))