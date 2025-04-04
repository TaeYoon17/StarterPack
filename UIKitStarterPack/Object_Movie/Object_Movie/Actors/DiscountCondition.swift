//
//  Interactor.swift
//  Object_Movie
//
//  Created by Greem on 4/4/25.
//

import Foundation
enum Lecture2 { }
extension Lecture2 {
    class TicketOffice:Hashable, Equatable {
        let id = UUID()
        static func == (lhs: Lecture2.TicketOffice, rhs: Lecture2.TicketOffice) -> Bool {
            lhs.id == rhs.id
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        func contract<T:AvailableDiscount>(_ theater: Theater<T>, rate: Double) -> Bool {
            return false
        }
        
        func cancel<T:AvailableDiscount>(_ theater: Theater<T>) -> Bool {
            return false
        }
        
    }
}
extension Lecture2 {
    class Theater<T: AvailableDiscount> {
        var ticketOffices: Set<TicketOffice> = .init()
        var movies: [Movie<T>: Set<Screening>] = [:]
        var amount: Money
        init(amount : Money) {
            self.amount = amount
        }
        
        func addMovie(movie: Movie<T>) -> Bool {
            guard !movies.contains(where: { $0.key.hashValue == movie.hashValue }) else {
                return false
            }
            movies[movie] = .init()
            return true
        }
        
        func addScreening(movie: Movie<T>, screen: Screening) -> Bool {
            guard movies.contains(where: { $0.key.hashValue == movie.hashValue }) else {
                return false
            }
            movies[movie]?.insert(screen)
            return true
        }
        
        func contractTicketOffice(ticketOffice: TicketOffice, rate: Double) -> Bool {
            if !ticketOffice.contract(self, rate: rate) {
                return false
            }
            ticketOffices.insert(ticketOffice)
            return true
        }
        
        func cancelTicketOffice(ticketOffice: TicketOffice) -> Bool {
            if !ticketOffices.contains(ticketOffice) || !ticketOffice.cancel(self) {
                return false
            }
            ticketOffices.remove(ticketOffice)
            return true
        }
        
        func plusAmount(amount: Money) {
            self.amount = self.amount.plus(amount)
        }
        
    }
}
class Screening: Hashable,Identifiable {
    
    var id = UUID()
    var seat: Int
    let sequence: Int
    let when: Date
    init(sequence: Int, when: Date , seat: Int) {
        self.seat = seat
        self.when = when
        self.sequence = sequence
    }
    
    func hasSeat(count: Int) -> Bool {
        seat >= count
    }
    
    func reserveSeat(count: Int) throws {
        if hasSeat(count: count) { seat -= count }
        else {
            throw CancellationError()
        }
    }
    static func == (lhs: Screening, rhs: Screening) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
struct Money {
    static func of(_ value: Double) -> Self { .init(amount: value) }
    var amount: Double
    func minus(_ money: Self) -> Self {
        Money(amount: self.amount - money.amount)
    }
    
    func plus(_ money: Self) -> Self {
        Money(amount: self.amount + money.amount)
    }
    
    func greaterThan(_ money: Self) -> Bool {
        self.amount >= money.amount
    }
    
    func multi(_ percent: Double) -> Self {
        Money(amount: Double(self.amount) * percent)
    }
}

protocol DiscountCondition {
    func isSatisfiedBy(screening: Screening, accountCount: Int) -> Bool
    
    func calculateFee(fee: Money) -> Money
}

class SequenceDiscount: DiscountCondition {
    private final var sequence: Int
    
    init(sequence: Int) {
        self.sequence = sequence
    }
    
    final func isSatisfiedBy(screening: Screening, accountCount: Int) -> Bool {
        return screening.sequence == sequence
    }
    
    func calculateFee(fee: Money) -> Money {
        return .init(amount: 2)
    }

}

 
/// 어떻게 할인 할 것인가?
/// 일정 부분을 그냥 할인해줌(Amount) 1000원 할인 쿠폰
class SequenceAmountDiscount: SequenceDiscount, DiscountPolicy.AMOUNT {
    var amount: Money
    init(sequence: Int,amount: Money) {
        self.amount = amount
        super.init(sequence: sequence)
    }
    
    override func calculateFee(fee: Money) -> Money {
        return fee.minus(amount)
    }
}

/// 어떻게 할인 할 것인가?
/// 일정 부분을 퍼센트로 나누어서 할인해줌(Percent) 5% 할인 쿠폰
/// 2중 if 문을 타입으로 처리함 -> Percent - Amount
class PercentAmountDiscount: SequenceDiscount, DiscountPolicy.PERCENT {
    var percent: Double
    
    init(sequence: Int, percent: Double) {
        self.percent = percent
        super.init(sequence: sequence)
    }
    
    override func calculateFee(fee: Money) -> Money {
        return fee.minus(fee.multi(percent))
    }
}

class Duration { }

typealias AvailableDiscount = DiscountPolicable & DiscountCondition & Hashable
class Movie<T: AvailableDiscount>: Hashable  {
    let id = UUID()
    static func == (lhs: Movie<T>, rhs: Movie<T>) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let title: String
    let runningTime: Duration
    let fee: Money
    let discountConditions: Set<T>
    
    init (title: String, runningTime: Duration, fee: Money, conditions: T...) {
        self.title = title
        self.runningTime = runningTime
        self.fee = fee
        self.discountConditions = Set(conditions)
    }
    
    func calculateFee(screening: Screening, audienceCount: Int) -> Money {
        /// 할인 조건이 있으면 제공한다.
        for condition in discountConditions {
            if condition.isSatisfiedBy(screening: screening, accountCount: audienceCount) {
                return condition.calculateFee(fee: fee).multi(Double(audienceCount))
            }
        }
        return fee
    }
}

struct Reservation<T: AvailableDiscount> {
    let theater: Theater
    let movie: Movie<T>
    let screening: Screening
    let account: Int
     
    init(theater: Theater, movie: Movie<T>, screening: Screening, account: Int) {
        self.theater = theater
        self.movie = movie
        self.screening = screening
        self.account = account
    }
}


