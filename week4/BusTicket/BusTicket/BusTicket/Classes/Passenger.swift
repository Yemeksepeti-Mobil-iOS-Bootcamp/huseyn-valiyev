//
//  Passenger.swift
//  BusTicket
//
//  Created by Huseyn Valiyev on 27.07.2021.
//

import Foundation

class Passenger {
    
    var name: String = ""
    var surname: String = ""
    var id: Int = 0
    
    init(name: String, surname: String, id: Int) {
        self.name = name
        self.surname = surname
        self.id = id
    }
    
    func printPassenger() {
        print("Passenger: \(name)-\(surname)-\(id)")
    }
    
}
