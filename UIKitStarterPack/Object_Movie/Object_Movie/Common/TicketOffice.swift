//
//  TicketOffice.swift
//  Object_Movie
//
//  Created by Greem on 4/2/25.
//

import Foundation

class TicketOffice: Hashable, Equatable {
    static func == (lhs: TicketOffice, rhs: TicketOffice) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    private let id: UUID = UUID()
    
    private var amount: Int = 0
    private var tickets: [Ticket] = []
    
    /// 티켓오피스의 자본
    init(amount: Int) {
        self.amount = amount
    }
    
    func addTicket(ticket: Ticket) {
        self.tickets.append(ticket)
    }
    
    
    func getTicketWithFee() -> Ticket? {
        if(tickets.isEmpty) {
            return nil
        }
        else {
            let ticket:Ticket =  tickets.removeFirst();
            self.amount += Int(ticket.getFee)
            return ticket
        }
    }
    
    
    func getTicketWithNoFee() -> Ticket? {
        if(tickets.isEmpty) {
            return nil
        }
        else {
            return tickets.removeFirst();
        }
    }
    
    func getTicketPrice() -> Double {
        return tickets.first?.getFee ?? 0
    }
}
