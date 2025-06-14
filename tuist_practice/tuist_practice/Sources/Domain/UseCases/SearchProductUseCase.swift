//
//  SearchProductUseCase.swift
//  tuist_practice
//
//  Created by Greem on 6/8/25.
//

import Foundation
import Combine

protocol SearchProductUseCase {
    func execute() -> AnyPublisher<ShoppingProduct,Never>
}

struct DefaultSearchProduct: SearchProductUseCase {
    
    
    init() { }
    
    func execute() -> AnyPublisher<ShoppingProduct, Never> {
        Just(ShoppingProduct()).eraseToAnyPublisher()
    }
}
