import Foundation
import AppIntents
import SwiftUI

// MARK: - 간단한 App Enum 예제
enum DrinkSize: String, AppEnum {
    case small = "small"
    case medium = "medium"
    case large = "large"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Drink Size"
    )
    
    static var caseDisplayRepresentations: [DrinkSize: DisplayRepresentation] = [
        .small: DisplayRepresentation(title: "Small", subtitle: "8oz"),
        .medium: DisplayRepresentation(title: "Medium", subtitle: "12oz"),
        .large: DisplayRepresentation(title: "Large", subtitle: "16oz")
    ]
}

// MARK: - 간단한 App Entity 예제
struct DrinkItem: AppEntity {
    var id: String
    var name: String
    var price: Int
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)", subtitle: "\(price)원")
    }
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Drink Item"
    )
    
    static var defaultQuery = DrinkItemQuery()
}

// MARK: - Entity Query
struct DrinkItemQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [DrinkItem] {
        return sampleDrinks.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [DrinkItem] {
        return sampleDrinks
    }
    
    private var sampleDrinks: [DrinkItem] {
        return [
            DrinkItem(id: "coffee", name: "커피", price: 3000),
            DrinkItem(id: "tea", name: "차", price: 2500),
            DrinkItem(id: "juice", name: "주스", price: 4000)
        ]
    }
}

// MARK: - 간단한 Intent
struct OrderDrinkIntent: AppIntent {
    static var title: LocalizedStringResource = "Order Drink"
    static var description = IntentDescription("음료를 주문합니다.")
    
    @Parameter(title: "Drink", description: "주문할 음료를 선택하세요")
    var drink: DrinkItem
    
    @Parameter(title: "Size", description: "사이즈를 선택하세요")
    var size: DrinkSize
    
    @Parameter(title: "Quantity", description: "수량", default: 1)
    var quantity: Int
    
    static var parameterSummary: some ParameterSummary {
        Summary("Order \(\.$quantity) \(\.$size) \(\.$drink)")
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let totalPrice = drink.price * quantity
        let message = "\(drink.name) \(size.rawValue) 사이즈 \(quantity)잔을 주문했습니다. 총 \(totalPrice)원입니다."
        
        return .result(dialog: IntentDialog(stringLiteral: message))
    }
}
