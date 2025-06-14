//
//  NetworkService.swift
//  tuist_practice
//
//  Created by Greem on 6/8/25.
//

import Foundation

final class NetworkService {
    
    private let session = URLSession.shared
    
    func getNaverProduct<T: Decodable>(type: T.Type, router: Router) async throws -> T {
        let (data, response) = try await session.data(for: router.asRequest())
        let value = try JSONDecoder().decode(type, from: data)
        return value
    }
}

extension URLRequest {
    var httpMethods: HTTPMethod {
        get {
            HTTPMethod(rawValue: self.httpMethod ?? "") ?? .get
        }
        set {
            self.httpMethod = newValue.rawValue
        }
    }
}
