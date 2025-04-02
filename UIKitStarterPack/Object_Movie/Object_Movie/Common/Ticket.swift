//
//  Ticket.swift
//  Object_Movie
//
//  Created by Greem on 4/2/25.
//

import Foundation

class Ticket: Hashable,Equatable {
    private var id = UUID()
    
    weak var theater: Theater!
    private var isEntered: Bool = false
    
    init(_ theater: Theater){
        self.theater = theater
    }
    
    func isValid(theater:Theater) -> Bool {
        if isEntered || self.theater != theater || self.theater == nil{
            return false
        } else {
            isEntered = true
            return true
        }
    }
    
    var getFee: Double {
        self.theater.fee
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Ticket, rhs: Ticket) -> Bool { lhs.id == rhs.id }
}
