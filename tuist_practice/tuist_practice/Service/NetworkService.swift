//
//  NetworkService.swift
//  tuist_practice
//
//  Created by Greem on 6/7/25.
//

import Foundation
import Network

struct Output: Codable {
    
}

final class NetworkService {
    
    
    func getHTTPInfo() async throws -> Output {
        var request = URLRequest(url: URL(string: "https://www.nvaer.com")!)
        request.httpMethod = "GET"
        let (value, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)
        let output: Output = try JSONDecoder().decode(Output.self, from: value)
        return output
    }
}
