//
//  RouterRequestconvertible.swift
//  tuist_practice
//
//  Created by Greem on 6/8/25.
//

import Foundation

protocol RouterRequestConvertible {
    
    func asRequest() -> URLRequest
}

/// Router를 사용하는 Enum은 RouterRequestConvertible을 상속받아야한다.
enum Router: RouterRequestConvertible {
    static let baseURL = ""
    case naverShopping(NaverShopping)
    
    func asRequest() -> URLRequest {
        switch self {
        case .naverShopping(let shopping): shopping.asRequest()
        }
    }
}
