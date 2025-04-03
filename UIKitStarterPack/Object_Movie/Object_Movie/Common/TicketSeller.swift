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
    
    /// 프리렌서라고 가정한다.
    func setTicketOffice(ticketOffice: TicketOffice) {
        self.ticketOffice = ticketOffice
    }
    
    func getTicket(audience: Audience) -> Ticket? {
        if audience.getInvitation() != nil {
            let ticket = ticketOffice.getTicketWithNoFee()
            if(ticket != nil) {
                audience.removeInvitation()
            }
            return ticket
        }
        else if audience.hasAmount(ticketOffice.getTicketPrice()) {
            let ticket = ticketOffice.getTicketWithFee()
            if ticket != nil {
                audience.minusAmount(ticketOffice.getTicketPrice())
            }
            return ticket
        }
        return nil
    }
}
