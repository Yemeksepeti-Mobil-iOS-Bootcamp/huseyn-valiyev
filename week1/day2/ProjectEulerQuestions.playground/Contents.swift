import UIKit

// Problem 1
// Bir for döngüsü içinde 3'e ve ya 5'e bölünen 1000'e kadar olan bütün sayıların toplamı bulunmuştur.
var count = 0
for i in 3..<1000 {
    if i % 3 == 0 || i % 5 == 0 {
        count += i
    }
}
print(count)

// Problem 2
// 4000000'a kadar olan çift fibonacci sayıları bulunmuştur.
var sum = 0
var first = 1
var last = 1

while last < 4000000 {
    if last % 2 == 0 {
        sum += last
    }
    let dummy = first + last
    first = last
    last = dummy
}
print(sum)

// Problem 3
// 600851475143 sayısının en büyük asal çarpanı bulunmuştur
var number = 600851475143
var primeFactor = 2

while number > 1 {
    if number % primeFactor == 0 {
        number /= primeFactor
    }else{
        primeFactor += 1
    }
}
print(primeFactor)

// Problem 4
// 3 basamaklı iki sayının çarpımından oluşan en büyük palindrom sayı bulunmuştur
func isPalindrome(value: String) -> Bool {
    let length = value.count / 2

    for i in 0..<length {
        let start = value.index(value.startIndex, offsetBy: i)
        let end = value.index(value.endIndex, offsetBy: (i * -1) - 1)
        if value[start] != value[end] {
            return false
        }
    }
    return true
}

var maxPalindrome = 0

for i in 100...999 {
    for j in 100...999 {
        let multiple = i * j
        let strMultiple = String(multiple)
        if isPalindrome(value: strMultiple) {
            if maxPalindrome < multiple {
                maxPalindrome = multiple
            }
        }
    }
}
print(maxPalindrome)

// Problem 5
// 1'den 20'ye kadar olan sayıların tamamına tam bölünebilen en küçük pozitif sayı bulunmuştur
func divisiblty(number: Int) -> Bool {
    for i in 2...20 {
        if number % i != 0 {
            return false
        }
        break
    }
    return true
}

var positiveNumber = 1

while !divisiblty(number: positiveNumber) {
    positiveNumber += 1
}
print(positiveNumber)
