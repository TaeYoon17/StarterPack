//
//  Movie2VC.swift
//  Object_Movie
//
//  Created by Greem on 4/4/25.
//

import UIKit

class Movie2VC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theater = Theater(money: Money.of(100))
        
        let movie = Movie<AmountDiscount>(
            "spiderman",
            Duration.ofMinutes(120),
            Money.of(5000.0),
            SequenceAmountDiscount(Money.of(1000.0), 1)
        )
        
        theater.addMovie(movie)
        
        for day in 7..<32 {
            var (hour,seq) = (10, 1)
            while hour < 24 {
                theater.addScreening(
                    movie,
                    Screening(
                        seq,
                        LocalDateTime.of(2019,7,day,hour,00,00),
                        100
                    )
                )
                hour += 3
                seq += 1
            }
        }
        
        let ticketOffice = TicketOffice(Money.of(0.0))
        theater.contractTicketOffice(ticketOffice, 10.0)
        
        let seller = TicketSeller()
        seller.setTicketOffice(ticketOffice)
        
        for screening in theater.getScreening(movie) {
            customer.reserve(seller, theater, movie, screening, 2)
            let isOK = theater.enter(audience: customer, 2)
            print(isOK) 
        }
    }
}
