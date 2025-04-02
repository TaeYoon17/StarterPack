//
//  Theater.swift
//  Object_Movie
//
//  Created by Greem on 4/1/25.
//

import Foundation



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
