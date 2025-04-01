//
//  Theater.swift
//  Object_Movie
//
//  Created by Greem on 4/1/25.
//

import Foundation

class Audience {
    
    
    func setInvitation(invitation: Invitation) {
        
    }
    
    func getTicket() -> Ticket {
        
    }
}

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

class Invitation {
    weak var theater: Theater!
    init(_ theater: Theater) {
        self.theater = theater
    }
}

class TicketOffice:Hashable,Equatable {
    private let id: UUID = UUID()
    
    private var amount: Int = 0
    private var tickets: [Ticket] = []
    
    init(amount: Int) {
        self.amount = amount
    }
    
    static func == (lhs: TicketOffice, rhs: TicketOffice) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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

class Theater:Equatable {
    private var id = UUID()
    static func == (lhs: Theater, rhs: Theater) -> Bool {
        lhs.id == rhs.id
    }
    
    private var ticketOffices: [TicketOffice] = []
    /// 금액을 알려준다.
    private(set) var fee: Double
    
    init(fee: Double) {
        self.fee = fee
    }
    
    
    /// 이 Theater에 등록할 ticketOffice들...
    func setTicketOffice(_ ticketOffice: TicketOffice ...) {
        self.ticketOffices.append(contentsOf: ticketOffice)
    }
    /// 티켓 오피스에게 티켓을 넘긴다..!
    func setTicket(_ ticketOffice: TicketOffice, num: Int){
        if !ticketOffices.contains(where: { $0 == ticketOffice }) { return }
        for _ in 0..<num {
            ticketOffice.addTicket(ticket: Ticket(self))
        }
    }
    
    /// 초대권을 청중에게 넘긴다.
    func setInvitation(audience: Audience){
        audience.setInvitation(invitation: Invitation(self))
    }
    
    func enter(audience: Audience) -> Bool {
        var ticket: Ticket = audience.getTicket()
        return ticket.isValid(theater: self)
    }
}
