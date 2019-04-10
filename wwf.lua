local wwf = {}

function wwf.read(filename)
    file, err = io.open(filename, "r+") -- открытие файла
    if err then
        print("Do not have file: ", filename)
    else
        data = file:read("*all")
        file:close()
        return data
    end
end

function wwf.write(filename, data)
    file = io.open(filename, "a") -- сохранение в файл 
    file:write(data)
    print("Creating..", filename)
    file:close()
end

return wwf