//
//  TicketSeller.swift
//  Object_Movie
//
//  Created by Greem on 4/1/25.
//

import Foundation

class TicketSeller: Hashable, Equatable {
    static func == (lhs: TicketSeller, rhs: TicketSeller) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private var id = UUID()
    private weak var ticketOffice: TicketOffice!
//    init() {
//        
//    }
    
    func setTicketOffice(ticketOffice: TicketOffice) {
        self.ticketOffice = ticketOffice
    }
    
    func getTicket(audience: Audience) -> Ticket {
        
    }
}
