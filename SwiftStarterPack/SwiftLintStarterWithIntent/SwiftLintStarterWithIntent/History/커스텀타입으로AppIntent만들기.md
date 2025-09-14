# AppIntents 커스텀 타입 만들기

AppIntents에서 커스텀 타입을 사용하여 더 풍부하고 유연한 앱 인터랙션을 만들 수 있습니다.

## 커스텀 타입의 종류

### 1. App Entity (앱 엔티티)
복잡한 데이터 구조를 표현하는 타입입니다. 사용자가 선택할 수 있는 객체들을 정의할 때 사용합니다.

```swift
struct CoffeeItem: AppEntity {
    var id: String
    var name: String
    var price: Int
    var size: CoffeeSize
    var isHot: Bool
    
    // 사용자에게 표시될 정보
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(name)",
            subtitle: "\(price)원 - \(size.displayName)"
        )
    }
    
    // 타입 정보
    static var typeDisplayRepresentation: TypeDisplayRepresentation = 
        TypeDisplayRepresentation(name: "Coffee Item")
    
    // 기본 쿼리
    static var defaultQuery = CoffeeItemQuery()
}
```

#### App Entity의 핵심 구성요소:
- **id**: 고유 식별자
- **displayRepresentation**: 사용자에게 표시될 정보
- **typeDisplayRepresentation**: 타입 자체에 대한 설명
- **defaultQuery**: 시스템이 엔티티를 검색할 때 사용하는 쿼리

### 2. App Enum (앱 열거형)
제한된 선택지를 제공할 때 사용하는 타입입니다.

```swift
enum CoffeeSize: String, AppEnum {
    case small = "small"
    case medium = "medium"
    case large = "large"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = 
        TypeDisplayRepresentation(name: "Coffee Size")
    
    static var caseDisplayRepresentations: [CoffeeSize: DisplayRepresentation] = [
        .small: DisplayRepresentation(title: "Small", subtitle: "8oz"),
        .medium: DisplayRepresentation(title: "Medium", subtitle: "12oz"),
        .large: DisplayRepresentation(title: "Large", subtitle: "16oz")
    ]
}
```

#### App Enum의 핵심 구성요소:
- **원시값**: String 기반의 고유 식별자
- **typeDisplayRepresentation**: 열거형 타입 자체에 대한 설명
- **caseDisplayRepresentations**: 각 케이스별 표시 정보

## Entity Query 구현

App Entity를 사용하려면 해당 엔티티를 검색하고 제공하는 쿼리를 구현해야 합니다.

```swift
struct CoffeeItemQuery: EntityQuery {
    // 특정 ID들에 해당하는 엔티티들을 반환
    func entities(for identifiers: [String]) async throws -> [CoffeeItem] {
        return allCoffeeItems.filter { identifiers.contains($0.id) }
    }
    
    // 추천 엔티티들을 반환 (사용자가 선택할 수 있는 옵션들)
    func suggestedEntities() async throws -> [CoffeeItem] {
        return allCoffeeItems
    }
    
    private var allCoffeeItems: [CoffeeItem] {
        // 실제 앱에서는 데이터베이스나 API에서 데이터를 가져옴
        return [...]
    }
}
```

## AppIntent에서 커스텀 타입 사용하기

```swift
struct OrderCoffeeIntent: AppIntent {
    static var title: LocalizedStringResource = "Order Coffee"
    static var description = IntentDescription("커피를 주문합니다.")
    
    // App Entity를 매개변수로 사용
    @Parameter(title: "Coffee Item", description: "주문할 커피를 선택하세요")
    var coffeeItem: CoffeeItem
    
    // App Enum을 매개변수로 사용
    @Parameter(title: "Size", description: "커피 사이즈를 선택하세요")
    var size: CoffeeSize
    
    // 기본 타입과 함께 사용
    @Parameter(title: "Quantity", default: 1)
    var quantity: Int
    
    // 매개변수 요약 정의
    static var parameterSummary: some ParameterSummary {
        Summary("Order \(\.$quantity) \(\.$coffeeItem) in \(\.$size) size")
    }
    
    func perform() async throws -> some IntentResult {
        // 주문 처리 로직
        return .result()
    }
}
```

## App Shortcuts 설정

커스텀 타입을 사용하는 Intent를 위한 바로가기를 설정합니다.

```swift
struct CoffeeAppShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: OrderCoffeeIntent(),
                phrases: [
                    "커피 주문하기",
                    "커피 시키기",
                    "\(.applicationName)에서 커피 주문"
                ],
                shortTitle: "커피 주문",
                systemImageName: "cup.and.saucer.fill"
            )
        ]
    }
}
```

## 사용 시나리오

1. **Siri를 통한 주문**: "커피 주문하기" → 시스템이 커피 종류와 사이즈를 묻고 주문 처리
2. **Spotlight 검색**: "커피" 검색 시 앱의 주문 기능이 나타남
3. **액션 버튼**: iPhone 15 Pro의 액션 버튼에 커피 주문 바로가기 설정 가능
4. **위젯**: 커피 주문 위젯에서 직접 주문 가능

## 주요 장점

1. **타입 안전성**: 컴파일 타임에 타입 체크가 이루어짐
2. **재사용성**: 한 번 정의한 커스텀 타입을 여러 Intent에서 사용 가능
3. **사용자 경험**: 풍부한 표시 정보로 더 나은 UX 제공
4. **시스템 통합**: Apple의 시스템 기능들과 자연스럽게 통합

## 실제 구현 예제

위에서 만든 파일들:
- `CustomAppIntentTypes.swift`: 커스텀 타입 정의
- `CoffeeOrderIntent.swift`: 커스텀 타입을 사용하는 Intent 구현
- `CoffeeAppShortcuts.swift`: App Shortcuts 설정

이 예제들을 통해 커피 주문 앱에서 사용할 수 있는 완전한 AppIntents 시스템을 구축했습니다.
