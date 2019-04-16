crypt = require("crypt") -- подключение модуля с криптографией
wwf = require("wwf") -- подключение модуля, работающего с файлами
gen = require("gen") -- подключение модуля, генерирующего гамму
parse = require("parse") -- подключения модуля, парсирующего буква-символ/символ-буква

alphabetFileName = "alphabet.txt"
alphabet = wwf.read(alphabetFileName) -- получение алфавита

operation = arg[1]
filePath = arg[2]
gammaPath = arg[3]
outputPath = arg[4]

if operation == "c" then
    inputFileName = filePath
    outputFileName = outputPath
    gammaFileName = gammaPath

    defaultGammaFileName = "gammaFile.txt"
    defaultOutputFileName = "cryptFile.txt"

    input = wwf.read(inputFileName) -- получение исходного текста

    if gammaFileName ~= "^" then
        gammaFromFile = parse.ReachLen(wwf.read(gammaFileName),string.len(input)) -- считывание гаммы из файла, предварительно достигшего нужной длины
        gamma = parse.CharToNumb(alphabet, gammaFromFile) -- парсинг его в таблицу
    else
        gammaFileName = defaultGammaFileName -- установка имени файла гаммы в дефолтное значение
        gamma = gen.gam(string.len(input), string.len(alphabet)) -- генерация гаммы
        wwf.write(gammaFileName, parse.NumbToChar(alphabet, gamma)) -- запись гаммы в файл как посл-сть букв
    end

    if outputFileName == "^" then
        outputFileName = defaultOutputFileName -- установка имени файла выходного в дефолтное значение
    end

    cipher = crypt.encrypt(alphabet, input, gamma) -- шифрование текста
    wwf.write(outputFileName, cipher) -- запись шифрограммы

elseif operation == "de" then
    inputFileName = filePath
    gammaFileName = gammaPath
    outputFileName = outputPath

    cipher = wwf.read(inputFileName) -- получение шифрограммы
    gammaStr = parse.ReachLen(wwf.read(gammaFileName), string.len(cipher)) -- получение гаммы
    decryptMessage = crypt.decrypt(alphabet, cipher, parse.CharToNumb(alphabet, gammaStr)) -- дешифрование шифрограммы
    wwf.write(outputFileName, decryptMessage) -- запись расшифрованного текста в файл
elseif operation == "help" then -- вывод помощи 
    print("<operation> <filename> <gammafile / '^'> <outputfile>")
    print("Operation:")
    print(" Encrypt: 'c'")
    print(" Decrypt: 'de'")
    print("Filename - your file with data")
    print("Gammafile - your file with gamma (if you have)")
    print("Outputfile - file to record the result of the command")
end