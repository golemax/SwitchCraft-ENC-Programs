local json = require("json")
local timestamp = require("timestamp")
local token = "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"

while true do
  local request = http.get("https://api.github.com/repos/SmallGolem/SwitchCraft-ENC-Programs",{["Authorization"]="Bearer "..token})
  time = IsoToTimestamp(json.decode(request.readAll()).updated_at)
  local request = http.get("https://worldtimeapi.org/api/timezone/Etc/UTC")
  currentTime = json.decode(request.readAll()).unixtime
  width, height = term.getSize()
  size = 604800/(currentTime-time)*(width-6)
  term.setBackgroundColor(colors.black)
  term.clear()
  paintutils.drawBox(2, 3, width-2, height/3*2, colors.white)
  paintutils.drawFilledBox(3, 4, 3+size, height/3*2-1, colors.yellow)
end