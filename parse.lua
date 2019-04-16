local parse = {}

function parse.CharToNumb(abc, str)
    t = {} --таблица с соответствиями
    alphStr = abc --строка с алфавитом
    for i = 1, string.len(alphStr) do
        t[string.sub(alphStr, i, i)] = i --установка соответствий
        if i == string.len(alphStr) then
            t[string.sub(alphStr, i, i)] = 0 --установка значения "0" в соответствие последней букве
        end
    end
    numbers = {} 
    for i = 1, string.len(str) do
        numbers[i] = t[string.sub(str, i, i)]
    end
    return numbers
end

function parse.NumbToChar(abc, squen)
    alph = abc
    _replacedTable = {}
    for i = 1, string.len(alph) do --генерация таблицы с переставленными ключ/значение
        if i == string.len(alph) then
            _replacedTable[0] = string.sub(alph, i, i)  
        else 
            _replacedTable[i] = string.sub(alph, i, i)
        end
    end
    str = ""
    for i = 1, table.getn(squen) do
        str = str .. _replacedTable[squen[i]]
    end
    return str
end

function parse.ReachLen(str, len)
    if string.len(str) > len then
        return string.sub(str, 1, len)
    else
        strForConcat = ""
        while string.len(strForConcat) < len do
            strForConcat = strForConcat .. str
        end
        return string.sub(strForConcat, 1, len)
    end
end

return parse