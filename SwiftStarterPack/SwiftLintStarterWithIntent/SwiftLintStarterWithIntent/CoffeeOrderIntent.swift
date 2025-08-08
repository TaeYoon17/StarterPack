import Foundation
import AppIntents
import SwiftUI
import UIKit

// MARK: - 커스텀 타입들

// App Enum (먼저 정의)
enum CoffeeSize: String, AppEnum {
    case small = "small"
    case medium = "medium"
    case large = "large"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Coffee Size"
    )
    
    static var caseDisplayRepresentations: [CoffeeSize: DisplayRepresentation] = [
        .small: DisplayRepresentation(title: "Small", subtitle: "8oz"),
        .medium: DisplayRepresentation(title: "Medium", subtitle: "12oz"),
        .large: DisplayRepresentation(title: "Large", subtitle: "16oz")
    ]
    
    var displayName: String {
        switch self {
        case .small: return "Small (8oz)"
        case .medium: return "Medium (12oz)"
        case .large: return "Large (16oz)"
        }
    }
}

// App Entity (CoffeeSize 다음에 정의)
struct CoffeeItem: AppEntity {
    var id: String
    var name: String
    var price: Int
    var size: CoffeeSize
    var isHot: Bool
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(name)",
            subtitle: "\(price)원 - \(size.displayName)"
        )
    }
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Coffee Item"
    )
    
    static var defaultQuery = CoffeeItemQuery()
    
    static let americano = CoffeeItem(
        id: "americano",
        name: "아메리카노", 
        price: 4500,
        size: .medium,
        isHot: true
    )
    
    static let latte = CoffeeItem(
        id: "latte",
        name: "카페라떼",
        price: 5500,
        size: .large,
        isHot: false
    )
}

// Entity Query
struct CoffeeItemQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [CoffeeItem] {
        return allCoffeeItems.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [CoffeeItem] {
        return allCoffeeItems
    }
    
    private var allCoffeeItems: [CoffeeItem] {
        return [
            CoffeeItem(id: "americano", name: "아메리카노", price: 4500, size: .medium, isHot: true),
            CoffeeItem(id: "latte", name: "카페라떼", price: 5500, size: .large, isHot: false),
            CoffeeItem(id: "cappuccino", name: "카푸치노", price: 5000, size: .medium, isHot: true),
            CoffeeItem(id: "espresso", name: "에스프레소", price: 3500, size: .small, isHot: true),
            CoffeeItem(id: "mocha", name: "카페모카", price: 6000, size: .large, isHot: false)
        ]
    }
}

// Order Status Enum
enum OrderStatus: String, AppEnum {
    case pending = "pending"
    case preparing = "preparing" 
    case ready = "ready"
    case completed = "completed"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Order Status"
    )
    
    static var caseDisplayRepresentations: [OrderStatus: DisplayRepresentation] = [
        .pending: DisplayRepresentation(title: "주문 대기", subtitle: "결제를 기다리는 중"),
        .preparing: DisplayRepresentation(title: "제조 중", subtitle: "커피를 만들고 있어요"),
        .ready: DisplayRepresentation(title: "준비 완료", subtitle: "픽업 대기 중"),
        .completed: DisplayRepresentation(title: "완료", subtitle: "주문이 완료되었어요")
    ]
}

// MARK: - 주문 정보 구조체
struct OrderInfo {
    let coffeeItem: CoffeeItem
    let size: CoffeeSize
    let quantity: Int
    let isHot: Bool
    let specialRequest: String?
    let totalPrice: Int
    let orderTime: Date
}

// MARK: - 커피 주문 Intent
struct OrderCoffeeIntent: AppIntent {
    static var title: LocalizedStringResource = "Order Coffee"
    static var description = IntentDescription("커피를 주문하고 주문 정보를 확인합니다.")
    
    // 커스텀 App Entity를 매개변수로 사용
    @Parameter(title: "Coffee Item", description: "주문할 커피를 선택하세요")
    var coffeeItem: CoffeeItem
    
    // 커스텀 App Enum을 매개변수로 사용  
    @Parameter(title: "Size", description: "커피 사이즈를 선택하세요")
    var size: CoffeeSize
    
    // 기본 타입도 함께 사용 가능
    @Parameter(title: "Quantity", description: "주문 수량", default: 1)
    var quantity: Int
    
    @Parameter(title: "Hot or Cold", description: "뜨거운 커피인가요?", default: true)
    var isHot: Bool
    
    // 선택적 매개변수 - 특별 요청사항
    @Parameter(title: "Special Request", description: "특별한 요청사항이 있나요?")
    var specialRequest: String?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Order \(\.$quantity) \(\.$coffeeItem) in \(\.$size) size") {
            \.$isHot
            \.$specialRequest
        }
    }
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        // 주문 처리 로직
        let totalPrice = coffeeItem.price * quantity
        let temperature = isHot ? "뜨거운" : "차가운"
        
        // 주문 정보 생성
        let orderInfo = OrderInfo(
            coffeeItem: coffeeItem,
            size: size,
            quantity: quantity,
            isHot: isHot,
            specialRequest: specialRequest,
            totalPrice: totalPrice,
            orderTime: Date()
        )
        
        // 커스텀 뷰 생성
        let snippet = OrderConfirmationView(orderInfo: orderInfo)
        
        // 다이얼로그 메시지 생성
        var dialogMessage = "\(temperature) \(coffeeItem.name) \(size.displayName) \(quantity)잔을 주문했습니다."
        if let request = specialRequest, !request.isEmpty {
            dialogMessage += " 특별 요청: \(request)"
        }
        dialogMessage += " 총 금액은 \(totalPrice)원입니다."
        
//        let dialog = IntentDialog(dialogMessage)
        let dialog = IntentDialog(stringLiteral: dialogMessage)
        
        return .result(dialog: dialog, view: snippet)
    }
}

// MARK: - 주문 상태 확인 Intent
struct CheckOrderStatusIntent: AppIntent {
    static var title: LocalizedStringResource = "Check Order Status"
    static var description = IntentDescription("주문 상태를 확인합니다.")
    
    @Parameter(title: "Order ID", description: "주문 번호를 입력하세요")
    var orderID: String
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        // 실제 앱에서는 서버에서 주문 상태를 가져올 것
        let mockStatus: OrderStatus = [.pending, .preparing, .ready, .completed].randomElement()!
        
        let dialog = IntentDialog("주문 번호 \(orderID)의 상태는 '\(OrderStatus.caseDisplayRepresentations[mockStatus]?.title ?? "알 수 없음")'입니다.")
        
        return .result(dialog: dialog)
    }
}

// MARK: - 커스텀 뷰
struct OrderConfirmationView: View {
    let orderInfo: OrderInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "cup.and.saucer.fill")
                    .foregroundColor(.brown)
                    .font(.title2)
                Text("주문 확인")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("상품:")
                        .fontWeight(.medium)
                    Spacer()
                    Text(orderInfo.coffeeItem.name)
                }
                
                HStack {
                    Text("사이즈:")
                        .fontWeight(.medium)
                    Spacer()
                    Text(orderInfo.size.displayName)
                }
                
                HStack {
                    Text("수량:")
                        .fontWeight(.medium)
                    Spacer()
                    Text("\(orderInfo.quantity)잔")
                }
                
                HStack {
                    Text("온도:")
                        .fontWeight(.medium)
                    Spacer()
                    HStack {
                        Image(systemName: orderInfo.isHot ? "thermometer.sun" : "snowflake")
                        Text(orderInfo.isHot ? "뜨거운" : "차가운")
                    }
                }
                
                if let specialRequest = orderInfo.specialRequest, !specialRequest.isEmpty {
                    HStack(alignment: .top) {
                        Text("특별 요청:")
                            .fontWeight(.medium)
                        Spacer()
                        Text(specialRequest)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            
            Divider()
            
            HStack {
                Text("총 금액:")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text("\(orderInfo.totalPrice)원")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            Text("주문 시간: \(orderInfo.orderTime, formatter: dateFormatter)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
