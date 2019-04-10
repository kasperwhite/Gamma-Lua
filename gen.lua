local gen = {}

function gen.gam(length, range)
    gamTab = {}
    for i = 1, length do 
        gamTab[i] = math.random(0, range) --составление гаммы
    end 
    return gamTab
end

return gen

