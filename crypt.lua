local crypt =  {}

function crypt.encrypt(abc, text, squen)
    function alphParse(str)
        t = {} --таблица с соответствиями
        alphStr = str --строка с алфавитом
        for i = 1, string.len(alphStr) do
            t[string.sub(alphStr, i, i)] = i --установка соответствий
            if i == string.len(alphStr) then
                t[string.sub(alphStr, i, i)] = 0 --установка значения "0" в соответствие последней букве
            end
        end
        return t
    end
    alph = abc
    message = text
    _randomTable = squen
    _gamTable = {}
    _output = {}
    _tFormFunc = alphParse(alph)
    _replacedTable = {}
    _outputText = ""
    for i = 1, string.len(message) do 
        _gamTable[i] = math.fmod((_randomTable[i] + _tFormFunc[string.sub(message, i, i)]), string.len(alph)) --получение последовательности гаммы
    end
    for i = 1, string.len(alph) do --генерация таблицы с переставленными ключ/значение
        if i == string.len(alph) then
            _replacedTable[0] = string.sub(alph, i, i)  
        else 
            _replacedTable[i] = string.sub(alph, i, i)
        end
    end
    for i = 1,string.len(message) do --нахождение соответствий буква/гамма
        _output[i] = _replacedTable[_gamTable[i]]
        _outputText = _outputText .. _output[i]
    end
    return _outputText
end

function crypt.decrypt(abc, cipher, gamma)
    function alphParse(str)
        t = {} --таблица с соответствиями
        alphStr = str --строка с алфавитом
        for i = 1, string.len(alphStr) do
            t[string.sub(alphStr, i, i)] = i --установка соответствий
            if i == string.len(alphStr) then
                t[string.sub(alphStr, i, i)] = 0 --установка значения "0" в соответствие последней букве
            end
        end
        return t
    end
    alph = abc
    _replacedTable = {}
    for i = 1, string.len(alph) do --генерация таблицы с переставленными ключ/значение
        if i == string.len(alph) then
            _replacedTable[0] = string.sub(alph, i, i)  
        else 
            _replacedTable[i] = string.sub(alph, i, i)
        end
    end
    
    _tFormFunc = alphParse(alph)
    _gammaArr = gamma

    _charToNumb = {}
    for i = 1, string.len(cipher) do --получение числовых значений каждой буквы
        _charToNumb[i] = _tFormFunc[string.sub(cipher, i, i)]
    end

    _resAfterSub = {}
    for i = 1, string.len(cipher) do --подсчет разности числ.знач/гаммы
        _resAfterSub[i] = _charToNumb[i] - _gammaArr[i]
        if (_charToNumb[i] - _gammaArr[i]) < 0 then
            _resAfterSub[i] = _resAfterSub[i] + string.len(abc)
        end
    end

    _output = {}
    _outputText = ""
    for i = 1, string.len(cipher) do --перевод выхода из чисел в буквы
        _output[i] = _replacedTable[_resAfterSub[i]]
        _outputText = _outputText .. _replacedTable[_resAfterSub[i]]
    end
    return _outputText
end

return crypt