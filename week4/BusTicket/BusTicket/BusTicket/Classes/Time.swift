//
//  Time.swift
//  BusTicket
//
//  Created by Huseyn Valiyev on 27.07.2021.
//

import Foundation

class Time {
    
    var hour: Int = 0
    var minute: Int = 0
    
    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    func printTime() {
        print("Hour: \(hour)")
        print("minute: \(minute)")
    }
    
}
