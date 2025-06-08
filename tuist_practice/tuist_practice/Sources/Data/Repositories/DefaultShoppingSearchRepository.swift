//
//  DefaultShoppingSearchRepository.swift
//  tuist_practice
//
//  Created by Greem on 6/8/25.
//

import Foundation

protocol ShoppingSearchRepository {
    func searchShoppingItem(term: String) async throws -> ShoppingProduct
}

final class DefaultShoppingSearchRepository: ShoppingSearchRepository {
    
    let service = NetworkService()
    
    func searchShoppingItem(term: String) async throws -> ShoppingProduct {
        let item = try await service.getNaverProduct(type: NaverProductDTO.self, router: Router.naverShopping(.get))
        return ShoppingProduct()
    }
    
}
