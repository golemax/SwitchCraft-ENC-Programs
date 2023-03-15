function IsoToTimestamp(data)
    local pattern = "(%d+)%-(%d+)%-(%d+)%a(%d+)%:(%d+)%:([%d%.]+)([Z%+%-])(%d?%d?)%:?(%d?%d?)"
    local year, month, day, hour, minute, seconds, offsetsign, offsethour, offsetmin = data:match(pattern)
    local timestamp = os.time({["year"] = tonumber(year), ["month"] = tonumber(month), ["day"] = tonumber(day), ["hour"] = tonumber(hour), ["min"] = tonumber(minute), ["sec"] = tonumber(seconds)})
    local offset = 0
    if offsetsign ~= 'Z' then
      offset = tonumber(offsethour) * 60 + tonumber(offsetmin)
      if xoffset == "-" then offset = offset * -1 end
    end
  
    return timestamp + offset
  end
  
  return {
    IsoToTimestamp = IsoToTimestamp
  }