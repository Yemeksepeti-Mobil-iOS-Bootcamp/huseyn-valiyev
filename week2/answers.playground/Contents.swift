import UIKit

//Girilen bir sayının asal olup olmadığını bulan bir extension yazınız

extension Int {
    func isPrime() -> Bool {
        if self == 2 {
            return true
        }else {
            for i in 2...Int(sqrt(Double(self))) {
                if self % i == 0 {
                    return false
                }
            }
            return true
        }
    }
}

// İki parametreli ve FARKLI tipli bir generic örneği yapınız... (T, U)

class Student {
    var firstName: String
    var lastName: String
        
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

func calculateGrade<T: Numeric, U: Student>(scores: [T], student: U) -> String {
    var sum = 0
    for score in scores {
        sum += score as! Int
    }
    let avarage = sum / scores.count
    
    switch avarage {
        case 80...90:
            return "AA"
        case 75...79:
            return "BA"
        case 70...74:
            return "BB"
        case 50...69:
            return "CB"
        case 45...49:
            return "CC"
        case 40...45:
            return "DC"
        case 20...39:
            return "DD"
        case 10...19:
            return "FD"
        case 0...9:
            return "FF"
        default:
            return "F0"
    }
}

print(calculateGrade(scores: [80,90,80], student: Student.init(firstName: "Huseyn", lastName: "Valiyev")))

// Euler project soru 6

func findDifferance(n: Int) {
    var sum = 0
    var squareSum = 0
    
    sum = n * (n + 1) / 2
    squareSum = n * (n + 1) * (2 * n + 1) / 6
    
    let result = sum * sum - squareSum
    print(result)
}
findDifferance(n: 100)

// Euler project soru 7

func isPrime(number: Int) -> Bool {
    if number == 2 {
        return true
    }else {
        for i in 2...Int(sqrt(Double(number))) {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
}

func largestPrime(range: Int) {
    var count = 0
    var number = 3
        
    while count < range {
        number += 1
        if isPrime(number: number) {
            count += 1
        }
    }
    print(number)
}

largestPrime(range: 10001)

// If let - guard let kullanım tercihini neye göre belirlersiniz?
// Sadece bazı değişkenleri unwrap etmek istiyorsak if let kullanımı mantıklıdır fakat, program akışında, devam etmeden kontrol gerekiyorsa guad let kullanmak daha mantıklıdır.
