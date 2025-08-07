//
//  NaverProductDTO.swift
//  tuist_practice
//
//  Created by Greem on 6/8/25.
//

import Foundation

struct NaverProductDTO: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: String      // 최저가 (문자열로 전송됨)
    let hprice: String      // 최고가 (문자열로 전송됨)
    let mallName: String
    let productId: String
    let productType: String
    let brand: String
    let maker: String
    let category1: String
    let category2: String
    let category3: String
    let category4: String
}

// MARK: - Convenience Extensions
extension NaverProductDTO {
    /// lprice를 Int로 변환하는 computed property
    var lowestPriceInt: Int? {
        Int(lprice)
    }
    
    /// hprice를 Int로 변환하는 computed property
    var highestPriceInt: Int? {
        Int(hprice)
    }
    
    /// productId를 Int로 변환하는 computed property
    var productIdInt: Int? {
        Int(productId)
    }
    
    /// HTML 태그가 포함된 title을 정리하는 computed property
    var cleanTitle: String {
        title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
