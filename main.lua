crypt = require("crypt") -- подключение модуля с криптографией
wwf = require("wwf") -- подключение модуля, работающего с файлами
gen = require("gen") -- подключение модуля, генерирующего гамму
parse = require("parse") -- подключения модуля, парсирующего буква-символ/символ-буква

alphabetFileName = "alphabet.txt"
gammaFileName = "gamma.gam"
inputFileName = "input.txt"
cipherFileName = "cipher.ciph"
decryptFileName = "decrypt.dec"

alphabet = wwf.read(alphabetFileName) -- получение алфавита

print("What do you want?") -- выбор пользователя
print("1: Encrypt")
print("2: Decrypt")
print("3: Delete all files")
choice = io.read("*number")

if choice == 1 then
    input = wwf.read(inputFileName) -- получение исходного текста
    gamma = gen.gam(string.len(input), string.len(alphabet)) -- генерация гаммы
    cipher = crypt.encrypt(alphabet, input, gamma) -- шифрование текста
    wwf.write(gammaFileName, parse.NumbToChar(alphabet, gamma)) -- запись гаммы в файл как посл-сть букв
    wwf.write(cipherFileName, cipher) -- запись шифрограммы
elseif choice == 2 then
    gammaStr = wwf.read(gammaFileName) -- получение гаммы
    cipher = wwf.read(cipherFileName) -- получение шифрограммы
    encryptMessage = crypt.decrypt(alphabet, cipher, parse.CharToNumb(alphabet, gammaStr)) -- дешифрование шифрограммы
    wwf.write(decryptFileName, encryptMessage) -- запись расшифрованного текста в файл
elseif choice == 3 then
    os.remove(gammaFileName)
    os.remove(cipherFileName)
    os.remove(decryptFileName)
else
    print("Unknown command")
end


--[[ do_ = arg[1]
io.write(do_)
if do_ == "c" then
    io.write("crypt")
end ]]