//
//  VisitorPattern.swift
//  oop_design_pattern
//
//  Created by Greem on 4/6/25.
//

/// 각 클래스들의 데이터 구조에서 처리 기능을 분리하여 별도의 클래스를 구성하는 패턴
/// 분리된 처리 기능은 각 클래스를 방문 하여 수행한다.

import Foundation

protocol VisitorAble {
    func accept(_ book: Behavior.VisitorBook) -> Int
    func accept(_ movie: Behavior.VisitorMovie) -> Int
    func accept(_ music: Behavior.VisitorMusic) -> Int
}

protocol VisitorElement {
    func accept(_ visitor: VisitorAble) -> Int
}

extension Behavior {
    
    class VisitorBook: VisitorElement {
        var price: Int { 2000 }
        
        /// Book에 accept 처리를 visitor에게 넘긴다.
        func accept(_ visitor: any VisitorAble) -> Int {
            visitor.accept(self)
        }
    }
    
    class VisitorMovie: VisitorElement {
        var ticketPrice: Int { 18000 }
        
        /// Movie에 accept 처리를 visitor에게 넘긴다.
        func accept(_ visitor: any VisitorAble) -> Int {
            visitor.accept(self)
        }
    }
    
    class VisitorMusic: VisitorElement {
        var albumPrice: Int { 600 }
        
        /// Music에 accept 처리를 visitor에게 넘긴다.
        func accept(_ visitor: any VisitorAble) -> Int {
            visitor.accept(self)
        }
    }
    
    class Visitor: VisitorAble {
        func accept(_ book: VisitorBook) -> Int {
            book.accept(self)
        }
        func accept(_ movie: VisitorMovie) -> Int {
            movie.ticketPrice
        }
        
            
        func accept(_ music: VisitorMusic) -> Int {
            music.albumPrice
        }
    }
 
               
    func startup() {
        let visitorable:VisitorAble = Visitor()
        
        let book = VisitorBook()
        let movie = VisitorMovie()
        let music = VisitorMusic()
        
        // accept 메서드에 내부 구현은 visitor가 알아서 한다.
        let totalPrice: Int = book.accept(visitorable) + movie.accept(visitorable) + music.accept(visitorable)
        
    }
    
}
