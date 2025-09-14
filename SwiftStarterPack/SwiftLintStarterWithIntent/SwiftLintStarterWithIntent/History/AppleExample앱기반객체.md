

## Making actions and content discoverable and widely available
앱 인텐트를 채택하여 Spotlight, 컨트롤, 위젯 및 액션 버튼으로 앱을 검색할 수 있도록 하세요.

> 링크: https://developer.apple.com/documentation/appintents/making-actions-and-content-discoverable-and-widely-available

### 개요
App Intents 프레임워크는 앱의 동작과 데이터를 표현하는 기능을 제공하여 Apple Intelligence가 제공하는 시스템 기능 및 Spotlight와 같은 시스템 환경과 긴밀하게 통합할 수 있도록 합니다. 앱 인텐트를 사용하면 사람들이 앱을 사용 중이든 시스템의 다른 곳에 있든, 언제 어디서든 앱의 콘텐츠를 보고 필요할 때 앱의 동작을 사용할 수 있습니다.

앱 인텐트 API는 여러 플랫폼 및 디바이스에서 시스템 경험과의 긴밀한 통합을 용이하게 하는 기본 프레임워크입니다. 이 프레임워크를 사용하여 데이터와 동작을 한 번 표현하면 **다양한 경험과 기능을 위한 재사용 가능한 기반**을 구축할 수 있습니다. 예를 들어, 앱 인텐트를 사용하여 앱을 Siri 및 Apple Intelligence와 통합한 다음 코드를 재사용하여 위젯 키트와 함께 컨트롤 및 대화형 위젯을 만들 수 있습니다.

### Review experiences that App Intents enables directly

App Intents 프레임워크를 사용하여 앱의 동작과 데이터를 표현하면 앱과 콘텐츠에 대한 광범위한 가시성을 제공하고 앱 자체 외부에서 해당 기능을 사용할 수 있는 시스템 환경과 앱을 통합할 수 있습니다. 예를 들어,
1. 사람들은 Siri를 사용하여 앱 동작을 수행합니다.
2. 사람들은 단축어 앱에서 만든 앱 단축어를 찾아 Siri, Spotlight, 동작 버튼, Apple Pencil Pro 등을 사용하여 여러 플랫폼과 기기에서 시스템 전체에서 이를 실행합니다.
3. 단축어 앱을 사용하면 앱의 기능을 활용한 맞춤형 단축어를 만들고 앱 전반에 걸쳐 완전히 새로운 워크플로를 구축할 수 있습니다.
4. 사람들은 Focus를 통해 방해 요소를 줄이고, App Intents 프레임워크를 사용하여 Focus 변경 사항에 대응할 수 있습니다. => 사용자가 집중 모드 기능을 활용하여 방해받지 않는 환경을 만든다.

지원되는 기기에서 App Intents 프레임워크는 강력한 생성 모델을 iPhone, iPad 및 Mac의 핵심 기능에 긴밀하게 통합하는 개인 인텔리전스 시스템인 Apple Intelligence와 통합됩니다. 
Siri는 Apple Intelligence의 기능을 활용하여 매일 사용하는 앱을 포함하여 모든 사용자에게 자연스럽고 상황에 맞는 맞춤형 지원을 제공합니다. 앱 인텐트 프레임워크를 사용하면 앱의 기능과 콘텐츠를 표현하고, 시스템이 이러한 컨텍스트에 접근할 수 있도록 하며, 앱을 Siri 및 Apple Intelligence와 통합하여 사용자가 기기 어디에서나 앱과 상호작용할 수 있는 새로운 방식을 제공합니다. 자세한 내용은 "Siri 및 Apple Intelligence와 액션 통합" 및 "Siri 및 Apple Intelligence에서 화면 콘텐츠 사용 설정"을 참조하세요.

### Understand experiences that use App Intents API

### Plan App Intents framework adoption
앱 인텐트 프레임워크를 처음 사용하는 경우 먼저 앱의 기능과 콘텐츠를 평가하세요. 이 프레임워크는 앱의 기본 구성 요소이며 광범위한 사용자 경험을 가능하게 하므로 앱 인텐트 기능을 염두에 두고 새 앱을 디자인하는 것이 중요합니다. 마찬가지로 기존 앱에 앱 인텐트를 도입할 때도 신중하고 신중한 접근 방식을 고려해야 합니다.
1. 앱 인텐트 프레임워크를 이해하고, 가능한 것들을 경험하기
2. 주요 프레임워크 개념을 검토하고 앱 인텐트로 앱을 실행하는 첫 번째 구현을 만들고 앱 바로가기를 추가하세요. 자세한 내용은 첫 번째 앱 인텐트 만들기 및 앱 바로가기를 참조하세요.
3. 앱 인텐트 프레임워크를 사용하여 추가 작업 및 콘텐츠를 표현합니다.
4. Siri 및 Apple Intelligence와 동작 및 콘텐츠 통합하기. 자세한 내용은 **App intent domains** 및 **Siri 및 Apple Intelligence와 동작 통합하기**를 참조하십시오.
5. Depending on your app’s functionality, add support for additional system experiences and interactions that fit your app’s functionality. For example, respond to Focus changes as described in Focus or add support for the Action button and squeeze gestures on Apple Pencil Pro, as described in Responding to the Action button on Apple Watch Ultra.

## Creating your first app intent

Spotlight 또는 바로 가기 앱과 같은 시스템 환경에서 앱을 사용할 수 있도록 하는 첫 번째 앱 인텐트를 만듭니다.
> 링크: https://developer.apple.com/documentation/appintents/creating-your-first-app-intent

사람들이 앱 자체 외부에서 앱의 기능을 활용할 수 있도록 하려면 Spotlight 및 바로 가기 앱과 같은 시스템 환경에서 앱의 동작과 콘텐츠를 이해하여 시스템에서 해당 기능을 노출할 수 있도록 도와주어야 합니다. 앱 인텐트를 사용하여 앱의 기능을 표현하고 앱의 동작을 시스템에서 사용할 수 있도록 하세요. 앱 인텐트는 코드와 시스템 경험 및 서비스 사이의 다리 역할을 하는 독립적인 유형입니다. 각 앱 인텐트는 앱에 특정한 단일 동작을 캡슐화합니다. 등산 앱에서 등산로에 대한 정보를 표시하거나, 예산 앱에서 개인의 거래 내역을 내보내거나, 변환기 앱에서 두 특정 측정 단위 간에 변환하는 등 앱의 대상에게 적합한 모든 작업을 시스템에 제공합니다.

모든 앱 인텐트는 Siri와 같은 경험과 서비스가 표시하거나 알릴 수 있는 **자신에 대한 설명 정보**를 제공합니다. 앱 인텐트가 포함된 앱을 빌드하면 컴파일러가 소스를 검사하고 해당 인텐트에 대한 데이터를 생성하여 Xcode가 앱 번들에 저장합니다. 누군가 앱을 설치하면 시스템은 해당 데이터를 사용하여 인텐트를 검색하고 시스템에서 사용할 수 있도록 합니다.

첫 번째 앱 인텐트 생성을 시작하기 전에 액션과 콘텐츠를 검색 가능하고 널리 사용 가능하게 만들기를 읽고 앱 인텐트 프레임워크의 특징과 기능을 검토하세요. 그런 다음 동작을 식별하고 첫 번째 앱 인텐트를 만든 다음 아래에 설명된 대로 App ShortCuts 제공하세요. App ShourtCuts를 사용하면 앱 인텐트를 더욱 유용하게 사용할 수 있습니다. 예를 들어, 앱 바로가기는 구성할 필요가 없으며 사람들이 액션 버튼에 배치할 수 있습니다. 또한 앱 바로가기는 사용자가 앱을 실행하지 않은 상태에서도 스포트라이트에 표시됩니다.

### Identify an action
> AppIntent는 초점을 좁게 잡고 한가지 일을 잘 수행하도록 구현해야한다.
AppIntent는 각각의 것을 개별적으로 호출할 수 있어야한다. 또한, 다른 앱이 이 인텐트 연계해도 문제가 없도록 만들어야한다.

### Review when to adopt specialized app intent protocols
> 특화 앱 인텐트 프로토콜을 적용하는 것을 검토하기

많은 앱 인텐트의 경우, 앱인텐트 프로토콜이 선호되는 프로토콜입니다. 그러나 앱의 특정 동작에 따라 코드가 다른 인텐트 프로토콜 중 하나를 따르는 것을 선호할 수도 있습니다.
1. Apple Intelligence가 제공하는 Siri의 향상된 동작 기능을 통해 사용자의 작업과 콘텐츠가 잘 작동하도록 하는 **어시스턴트 스키마**를 준수하는 앱 인텐트를 만듭니다.
2. 앱에서 오디오를 재생하거나 녹음하고 앱 인텐트에서 동일한 기능을 제공하려는 경우 AudioPlaybackIntent를 대신 채택하세요. 이 프로토콜은 앱 인텐트에서 상속되며 오디오 관련 동작을 시스템에 표시하여 가능한 경우 오디오 상호 작용 및 기타 잠재적인 중단을 방지합니다.
-> Apple Intelligence 특화 앱 인텐트가 따로 있다.
-> 음성 녹음 및 재생에 특화된 앱 인텐트가 있다. -> AudioPlaybackIntent

### Create an app intent that opens your app

액션을 정의하려면 앱인텐트 프로토콜을 채택하는 유형 또는 필요한 특정 동작을 제공하는 관련 프로토콜을 만듭니다.

가능하면 매개 변수가 필요 없는 간단한 액션으로 시작하세요. 또는 동작에 매개변수가 필요한 경우 처음에 매개변수를 하드코딩하여 첫 번째 앱 인텐트 구현이 작동하도록 하는 것이 좋습니다. 그런 다음 앱 인텐트에 매개변수 추가에 설명된 대로 첫 번째 앱 인텐트에 매개변수를 추가하도록 변경합니다.

> 참고 문서 - Adding parameters to an app intent https://developer.apple.com/documentation/appintents/adding-parameters-to-an-app-intent
``` swift
struct OpenFavorites: AppIntent {
    
    static var title: LocalizedStringResource = "Open Favorite Trails"


    static var description = IntentDescription("Opens the app and goes to your favorite trails.")
    
    static var openAppWhenRun: Bool = true // 이미 AppIntent에 정의되어있는 프로퍼티
    
    @MainActor
    func perform() async throws -> some IntentResult {
        navigationModel.selectedCollection = trailManager.favoritesCollection
        
        return .result()
    }
    
    @Dependency
    private var navigationModel: NavigationModel
    
    @Dependency
    private var trailManager: TrailDataManager
}
```

구조에서 프로토콜의 제목 요구 사항을 구현하여 바로 가기 앱이 작업 라이브러리 및 바로 가기 편집기에 표시하는 현지화된 텍스트를 제공하세요. 인텐트에 대한 추가 컨텍스트를 포함하려면 선택적 설명 요구 사항을 구현하여 앱 인텐트의 동작을 설명하는 현지화된 텍스트를 제공하세요. 바로 가기 앱은 작업 라이브러리에 설명을 표시합니다.

### Perform the app intent's action

인텐트의 기능을 제공하려면 `perform()` 프로토콜 요구 사항을 구현하세요. 시스템은 *필요한 매개변수*를 확인한 후에 이 메서드를 호출하므로 코드가 함수 본문에서 해당 매개변수에 액세스해도 안전합니다.

``` swift
func perform() async throws -> some IntentResult & ReturnsValue<TrailEntity> & ProvidesDialog & ShowsSnippetView {
    guard let trailData = trailManager.trail(with: trail.id) else {
        throw TrailIntentError.trailNotFound
    }
            
    /**
     perform() 함수의 반환 타입이 `ShowsSnippetView` 프로토콜을 채택하도록 하여 커스텀 뷰를 제공합니다.
     */
    let snippet = TrailInfoView(trail: trailData, includeConditions: true)
    
    /**
     이 인텐트는 트레일 상태 정보를 포함하는 커스텀 뷰를 표시합니다. 시스템이 응답을 읽기만 할 수 있고 화면에 표시할 수 없는 경우, 다이얼로그에 트레일 상태 정보가 포함됩니다. 시스템이 응답을 화면에 표시할 수 있을 때는, 다이얼로그에서 트레일 상태 정보가 생략됩니다.
     */
    let dialog = IntentDialog(full: "The latest conditions reported for \(trail.name) indicate: \(trail.currentConditions).",
                              supporting: "Here's the latest information on trail conditions.")
    
    return .result(value: trail, dialog: dialog, view: snippet)
}
```

구현은 필요한 작업을 완료하고 시스템에 결과를 반환해야 합니다. 결과에는 무엇보다도 바로가기가 후속 연결된 작업에서 사용할 수 있는 값, 표시하거나 알릴 대화 상자, SwiftUI 스니펫 보기 등이 포함될 수 있습니다.

> #### 주의 사항

기본적으로 시스템은 백그라운드에서 제한된 모드로 앱을 실행하고 임의의 대기열에서 인텐트의 perform() 메서드를 실행합니다.

이 동작을 재정의하고 앱을 포그라운드에서 실행하려면 인텐트의 `openAppWhenRun` 변수를 true로 설정하세요. 인텐트가 앱의 사용자 인터페이스를 업데이트하는 경우 perform() 메서드가 기본 대기열에서 실행되도록 `@MainActor`로 perform()에 주석을 달아야 합니다.

=> openAppWhenRun은 deprecated 된 상태로 앞으로는 `supportedModes` 라는 변수를 적용할 것 (iOS 26 부터...)
> 앱이 포그라운드에 있지 않더라도 AppIntent를 고려하도록 시스템에 지시하는 부울 속성입니다.

`openWhenRun == true` => 인텐트가 실행될 때 앱이 포그라운드로 전환되어야 함을 나타냅니다. 복잡한 UI 상호작용이 필요하거나, 사용자에게 진행 상황을 시각적으로 보여줘야 할 때

### Design custom responses

사람들은 Siri를 통해 앱 인텐트와 상호 작용할 수 있습니다. 좋은 사용자 경험을 위해 인텐트의 결과를 사용자 지정 UI 스니펫을 사용하여 시각적 응답으로 전달하고 Siri가 동일한 정보를 전달할 수 있도록 대화 상자로 전달하는 것을 고려하세요. 자세한 내용은 사용자 지정 응답 디자인하기를 참조하세요.
> 링크: https://developer.apple.com/documentation/appintents/acceleratingappinteractionswithappintents#Design-custom-responses

### Receive input with parameters and return results

앱에서 화면을 여는 앱 인텐트를 만드는 것은 앱 인텐트 프레임워크에 익숙해지고 앱과 앱의 콘텐츠를 검색 가능하게 만드는 첫 번째 단계입니다. 앱의 많은 동작이 입력을 받고 데이터를 반환합니다.

데이터를 수신하고 반환하는 동작을 설명하려면 앱 인텐트에 매개변수를 추가하여 해당 데이터에 대한 정보와 필수 또는 선택 여부를 시스템에 알려줍니다.

매개 변수를 노출하면 사람들이 요구 사항에 맞는 고유한 값으로 인텐트를 구성하고 앱 인텐트 프레임워크가 시스템 경험과 통신하여 런타임에 해당 값을 작성할 수 있도록 할 수 있습니다.

예를 들어, Accelerating app interactions with App Intents 프로젝트를 사용하면 사람들이 앱 인텐트를 호출할 때 어떤 하이킹 코스 정보를 볼지 선택할 수 있습니다. 앱 인텐트에서 매개변수를 사용하는 방법에 대한 자세한 내용은 Adding parameters to an app intent를 참조하세요.

### Create an App Shortcut

생성한 앱 인텐트는 App Shortcut에 표시됩니다. 사람들은 앱 인텐트를 시작하는 사용자 지정 App Shortcut을 만들고 앱 인텐트를 결합하여 사용자 지정 워크플로를 수행할 수 있습니다. 사람들이 별도의 구성 없이 앱 인텐트를 검색하고 실행할 수 있도록 하려면 앱의 앱 인텐트를 앱 바로가기에 번들로 묶어 앱 작업의 워크플로우를 제공하세요.

앱 바로가기를 제공하면 바로 가기 앱이나 Siri에 추가 버튼에서 설정하지 않아도 앱을 설치하는 순간부터 바로 가기, Spotlight 및 Siri에서 앱의 기능을 즉시 사용할 수 있습니다. 액션 버튼을 지원하는 디바이스에서는 액션 버튼으로 앱 바로가기를 호출하여 앱의 기능에 빠르게 액세스할 수 있습니다.

첫 번째 앱 인텐트에 대한 앱 바로가기를 제공하려면 다음과 같이 하세요:

init(intent:phrases:shortTitle:systemImageName:) 초기화 프로그램을 사용하여 앱 인텐트에 대한 앱숏컷 개체를 생성하고 사람들이 앱 인텐트를 실행하는 데 사용할 수 있는 문구와 바로 가기 앱에 표시되는 메타데이터를 제공합니다.

단축키 앱에 제공하는 앱 단축키를 제공하는 AppShortcutsProvider 프로토콜을 구현합니다.

앱 바로가기를 만드는 방법에 대한 자세한 내용은 앱 바로가기와 앱 바로가기를 참조하세요.

iPhone 및 Apple Watch에서 동작 버튼을 지원하는 방법에 대해 자세히 알아보려면 Apple Watch Ultra에서 동작 버튼에 응답하기를 참조하세요.
