//
//  Audience.swift
//  Object_Movie
//
//  Created by Greem on 4/2/25.
//

import Foundation

class Audience {
    private var ticket: Ticket?
    private var invitation: Invitation?
    private var amount: Double
    
    
    init(amount: Double) {
        self.amount = amount
    }
    
    public func buyTicket(ticketSeller: TicketSeller) {
        self.ticket = ticketSeller.getTicket(audience: self)
    }
    
    func hasAmount(_ fee: Double) -> Bool { amount >= fee }
    
    func minusAmount(_ fee: Double) -> Bool {
        if fee > amount { return false }
        amount -= fee
        return true
    }
    
    func getInvitation() -> Invitation? { self.invitation }
    func setInvitation(invitation: Invitation) { self.invitation = invitation }
    func removeInvitation() { self.invitation = nil }
    
    
    func getTicket() -> Ticket?  { self.ticket }
}
