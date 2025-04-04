//
//  DiscountPolicy.swift
//  Object_Movie
//
//  Created by Greem on 4/4/25.
//

import Foundation
enum DiscountPolicy {
    protocol AMOUNT: DiscountPolicable { }
    protocol PERCENT: DiscountPolicable { }
    protocol COUNT: DiscountPolicable { }
    protocol NONE: DiscountPolicable { }
    
}
protocol DiscountPolicable {
    // 기본 DiscountPolicy 프로토콜은 비어있습니다
}
//
//// DiscountPolicy를 확장하는 하위 프로토콜들
//protocol AMOUNT: DiscountPolicy {
//    // AMOUNT 관련 요구사항
//}
//
//protocol PERCENT: DiscountPolicy {
//    // PERCENT 관련 요구사항
//}
//
//protocol COUNT: DiscountPolicy {
//    // COUNT 관련 요구사항
//}
//
//protocol NONE: DiscountPolicy {
//    // NONE 관련 요구사항
//}
//
//
