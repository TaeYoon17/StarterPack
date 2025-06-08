//
//  NaverShoppingRouter.swift
//  tuist_practice
//
//  Created by Greem on 6/8/25.
//

import Foundation

extension Router {
    enum NaverShopping: RouterRequestConvertible {
        case get
        
        var method: HTTPMethod {
            switch self {
            case .get: .get
            }
        }
        
        func asRequest() -> URLRequest {
            var request = URLRequest(url: URL(string: "asfasd")!)
            request.httpMethods = self.method
            return request
        }
    }
}
