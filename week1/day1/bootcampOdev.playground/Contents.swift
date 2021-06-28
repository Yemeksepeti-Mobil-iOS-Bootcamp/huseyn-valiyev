import UIKit

/* Soru: Elimizde sadece harflerden oluşan (noktalama işareti veya sayılar yok) uzun karakterler olsun. Bu karekterlerin içinde bazı hafrflerin tekrar edeceğini düşünün. Mesela 'a ' harfi 20 farklı yerde geçiyor. Bir fonksiyon ile verilen parametre değerine eşit ve daha fazla bulunan harfler silinecektir. Sonra geriye kalan string ekrana yazdırılacaktır. Not boşluklar sayılmayacak:)
*/

/* Çözüm : İlk önce bize verilen Stringin hangi karakterlerden oluştuğunu bulmak için bir Set yapısınına aktarıyoruz, daha sonra her bir karakterin kaç kez kullanıldığını bulup bu karakterleri bir diziye atıp removeAll fonksiyonu yardımıyla bu karakterleri Stringden siliyoruz.
*/
func removeCharacter(text: inout String, count: Int) {
    let textSet = Set(text)
    var deletedCharacters: [Character] = []

    for character in textSet {
        var repeatCount = 0
        for textCharacter in text {
            if character == textCharacter {
                repeatCount += 1
            }
        }
        if repeatCount >= count {
            if character != " " {
                deletedCharacters.append(character)
            }
        }
    }
    text.removeAll(where: {deletedCharacters.contains($0)})
    print(text)
}

var text = "aaba kouq bux"
removeCharacter(text: &text, count: 2)

/*
 Elimizde uzun bir cümle olsun, Bazı kelimeler tekrar edecek bir cümle düşünün. İstediğimiz ise, hangi kelimeden kaç tane kullanıldığını bulmanız.
 */

// Çözüm:

var string = "merhaba nasılsınız . iyiyim siz nasılsınız . bende iyiyim."
string = string.replacingOccurrences(of: ".", with: "")
var stringArray = string.components(separatedBy: " ")
let wordSet = Set(stringArray)
let wordArray = Array(wordSet)
var wordCount: [Int] = []
for word in wordArray {
    var count = 0
    for string in stringArray {
        if word == string {
            count += 1
        }
    }
    wordCount.append(count)
}
for i in 0..<wordArray.count {
    if wordArray[i] != "" && wordArray[i] != "." {
        print("\(wordArray[i]): \(wordCount[i])")
    }
}
