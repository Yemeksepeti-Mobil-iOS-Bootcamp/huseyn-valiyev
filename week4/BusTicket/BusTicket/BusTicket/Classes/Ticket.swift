//
//  Ticket.swift
//  BusTicket
//
//  Created by Huseyn Valiyev on 27.07.2021.
//

import Foundation

class Ticket {
    
    var passenger: Passenger?
    var date: Date?
    var time: Time?
    var seats: [Int]?
    var seatCount: Int = 0
    
    func compareTicket(ticket: Ticket) -> Bool {
        if let seats = self.seats {
            for seat in ticket.seats! {
                if seats.contains(seat) {
                    return true
                }
            }
            return false
        }
        return false
    }
    
    func reserveSeat(seatCount: Int) -> [Int] {
        if seatCount > 0 {
            return seats!
        } else {
            let tempArray = repeatElement(0, count: seatCount)
            let tempIntArray = tempArray.map{Int($0)}
            return tempIntArray
        }
    }
    
    func addSeat(seatNumber: Int) {
        seats?.append(seatNumber)
    }
    
}
