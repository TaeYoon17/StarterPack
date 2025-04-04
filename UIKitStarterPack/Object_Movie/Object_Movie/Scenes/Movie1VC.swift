//
//  ViewController.swift
//  Object_Movie
//
//  Created by Greem on 4/1/25.
//

import UIKit

final class Movie1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBlue
        
        let theater = Theater(fee: 100)
        let ticketOffice = TicketOffice(amount: 10)
        let seller = TicketSeller()
        
        let audience1 = Audience(amount: 0)
        let audience2 = Audience(amount: 50)
        
        theater.setTicketOffice(ticketOffice)
        theater.setTicket(ticketOffice, num: 20)
        
        theater.setInvitation(audience: audience1)
        
        seller.setTicketOffice(ticketOffice: ticketOffice)
        
        audience1.buyTicket(ticketSeller: seller)
        audience2.buyTicket(ticketSeller: seller)
        
        let isOK1 = theater.enter(audience: audience1)
        let isOK2 = theater.enter(audience: audience2)
        
        print(isOK1)
        print(isOK2)
        
    }


}

