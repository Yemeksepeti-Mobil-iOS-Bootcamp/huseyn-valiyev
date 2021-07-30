//
//  Date.swift
//  BusTicket
//
//  Created by Huseyn Valiyev on 27.07.2021.
//

import Foundation

class Date {
    
    var day: Int = 0
    var month: Int = 0
    var year: Int = 0
    
    init(dd: Int, MM: Int, YYYY: Int) {
        self.day = dd
        self.month = MM
        self.year = YYYY
    }
    
    func printDate() {
        print("Date: \(day)/\(month)/\(year)")
    }
    
}
