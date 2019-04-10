local time = {}

function time.gettime()
    date_table = os.date("*t")
    ms = string.match(tostring(os.clock()), "%d%.(%d+)")
    hour, minute, second = date_table.hour, date_table.min, date_table.sec
    year, month, day = date_table.year, date_table.month, date_table.wday
    result = string.format("%d-%d-%d %d:%d:%d:%s", year, month, day, hour, minute, second, ms)

    return result
end

return time