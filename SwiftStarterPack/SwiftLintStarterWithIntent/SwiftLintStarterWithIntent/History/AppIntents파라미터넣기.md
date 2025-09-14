## Adding parameters to an app intent

사용자 지정 입력 값으로 앱 인텐트를 구성할 수 있습니다.
> 링크 https://developer.apple.com/documentation/appintents/adding-parameters-to-an-app-intent

앱의 많은 동작은 작업을 수행하기 위해 입력 데이터가 필요할 수 있습니다.

사람들이 앱 인텐트가 기능을 수행하는 데 필요한 입력을 제공할 수 있도록 인텐트에 매개 변수를 추가하여 시스템에 해당 데이터와 필수 또는 선택 사항 여부를 알려줍니다.

이러한 매개 변수를 노출하면 사람들은 자신의 요구 사항에 맞는 고유한 값으로 인텐트를 구성하고 앱 인텐트 프레임워크가 시스템 경험을 중재하여 런타임에 해당 값을 작성하도록 할 수 있습니다.

#### 주요 객체: IntentParameter / Class
associated property, 앱 인텐트의 입력 아규면트를 실행하게 돕는다.

``` swift
@propertyWrapper
final class IntentParameter<Value> where Value : _IntentValue, Value : Sendable
```
##### What is _IntentValue??
1. Swift의 기본 값들... => URL도 가능하다..!
- Ingegers / Doubles / Booleans / Strings / URLs
2. 일반적인 framework에서 제공하는 값
- Dates / Date components / Files / Currencies / Payments / People / Placemarks / Measurements
  + Measurements란? 온도, 질량, 속도, 에너지, 지속 시간, 길이, 부피 값 등이 포함된 파라미터 변수에 대한 세부 정보를 구성할 수 있습니다.
  https://developer.apple.com/documentation/appintents/intentparameter-measurements
3. 커스텀 타입 만들기
- App entities - 사용자 지정 앱 엔티티를 포함하는 매개변수 변수에 대한 세부 정보를 구성합니다.
    + 앱엔티티 프로토콜을 채택하고 시스템이 **런타임**에 요청할 수 있는 사용자 지정 유형을 사용합니다.
- App enums - Configure the details for parameter variables that contain custom app enums.
   + **빌드 시점**에 알려진 정적 값을 가진 매개변수에는 AppEnum 프로토콜을 준수하는 열거 가능 유형을 사용합니다.

### Make a parameter optional or required

매개변수 변수를 정의하는 방식에 따라 시스템에서 해당 매개변수를 필수로 취급할지, 아니면 선택 사항으로 취급할지가 결정됩니다.

변수를 비선택적 유형으로 정의하면 시스템에서 해당 변수를 필수로 인식하고 필요한 경우 값을 요청합니다. 반대로 변수를 선택적 유형으로 정의하면 시스템에서는 해당 매개변수가 선택적이라고 가정하고 값을 요청하지 않습니다. 이 시나리오에서는 속성 래퍼의 requestValue(_:) 메서드를 사용하여 실행을 일시 중지하고 그렇지 않으면 인텐트를 진행할 수 없는 경우 값을 요청합니다.

``` swift
guard let date = date else {
    throw $date.requestValue("What date would you like to use?")
}
```

### Transform input into your intent parameter’s types

사용자가 앱 인텐트가 사용하는 입력을 제공할 때 입력이 매개변수에 필요한 유형과 항상 일치하는 것은 아닙니다.

예를 들어 Siri의 자연어 명령은 문자열이지만 앱 인텐트에는 정수 또는 부동 소수점 값이 필요할 수 있습니다.

다양한 유형의 입력을 지원하려면 **리졸버**를 사용하여 한 유형을 다른 유형으로 자동 변환하는 시스템의 기능을 활용하여 앱 인텐트가 입력을 사용할 수 있도록 하세요.

> 리졸버 관련 링크 https://developer.apple.com/documentation/appintents/resolvers

### Restrict parameter values
- 사람들이 앱 인텐트에 올바른 정보를 쉽게 제공할 수 있도록 매개변수 값을 제한하세요
- 시스템은 알려진 값을 목록으로 표시하고 매개변수를 해결해야 할 때 사용자에게 값을 선택하라는 메시지를 표시합니다.

- 매개변수 값을 알려진 값의 목록으로 제한하려면 다음과 같이 하세요
1. 컴파일 시 매개변수에 AppEnum 프로토콜을 준수하는 열거 형을 사용합니다.

2. 런타임에는 프로퍼티 래퍼 선언의 일부로 옵션 프로바이더를 지정합니다. 옵션 프로바이더는 DynamicOptionsProvider 프로토콜을 준수하고 런타임에 허용된 값 집합을 제공하는 구현하는 유형입니다.
+ 예를 들어, 앱 인텐트로 앱 상호 작용 가속화 샘플 코드 프로젝트는 동적 옵션 공급자를 사용하여 바로 가기 앱에 정렬된 위치 매개변수 목록을 표시합니다.


``` swift
struct LocationOptionsProvider: DynamicOptionsProvider {
    
    @Dependency
    private var trailManager: TrailDataManager
    
    func results() async throws -> [String] {
        Logger.intentLogging.debug("Getting locations from LocationOptionsProvider")
        
        // Get a list of locations and return it sorted for display, such as in the Shortcuts app.
        return trailManager.uniqueLocations
                .sorted(using: KeyPathComparator(\.self, comparator: .localizedStandard))
    }
}
```

숫자 유형에 포함 범위를 적용하거나 문자열 유형에 대문자 스타일 및 키보드 모드를 지정하는 등의 추가 옵션을 사용하여 매개변수를 구성할 수 있습니다. 자세한 내용은 **IntentParameter**를 참조하세요.

### Provide an interactive parameter summary for your intent
매개변수 요약은 바로 가기 앱이 바로 가기 편집기에 표시하는 앱 의도에 대한 시각적, 텍스트 개요입니다.

요약에는 사람들이 인텐트의 매개변수 값을 선택하기 위해 상호작용하는 플레이스홀더가 포함될 수 있습니다. 인텐트에 매개 변수가 노출되지 않더라도 요약을 제공하면 제목과 함께 인텐트에 대한 자세한 정보를 제공할 수 있습니다.

``` swift
static var parameterSummary: some ParameterSummary {
        Summary("Get information on \(\.$trail)")
    }
```

바로 가기 편집기는 각 키 경로를 해당 매개변수의 제목으로 대체하고 사용자가 해당 경로를 탭하여 값을 설정할 수 있도록 합니다. 편집기는 매개변수의 유형을 사용하여 표시할 입력 컨트롤을 결정합니다.

매개변수 요약에는 이미 선택된 값에 대한 응답으로 요약이 자체적으로 업데이트되도록 하는 `AppIntent.When` 및 `AppIntent.Switch`와 같은 조건문이 포함될 수 있습니다.

예를 들어, 앱 인텐트로 앱 상호 작용 가속화 샘플 코드 프로젝트는 SuggestedTrails 앱 인텐트에서 AppIntent.Switch를 사용합니다.

``` swift
 static var parameterSummary: some ParameterSummary {
        Switch(\.$activity) {
            Case(.biking) {
                When(\.$location, .hasAnyValue) {
                    Summary("Ride a bike within \(\.$searchRadius) of \(\.$location)")
                } otherwise: {
                    When(\.$trailCollection, .hasAnyValue) {
                        Summary("Pick a bike ride from \(\.$trailCollection)")
                    } otherwise: {
                        Summary("Suggest bike rides from \(\.$trailCollection) or near \(\.$location)")
                    }
                }
            }
            DefaultCase() {
                When(\.$location, .hasAnyValue) {
                    Summary("Suggest \(\.$activity) trails within \(\.$searchRadius) of \(\.$location)")
                } otherwise: {
                    When(\.$trailCollection, .hasAnyValue) {
                        Summary("Suggest \(\.$activity) trails from \(\.$trailCollection)")
                    } otherwise: {
                        Summary("Suggest \(\.$activity) trails from \(\.$trailCollection) or near \(\.$location)")
                    }
                }
            }
        }
    }
```

=> 동작인 placeholder를 만들기 위한 요소 같다..?

### Review the role of app entities
앱 엔티티란, 앱의 데이터(예: 사진, 앨범)나 데이터와 관련된 개념(예: 최근 사진, 기본 앨범 등)을 시스템에 알려주는 역할을 합니다.  
앱 인텐트에서 매개변수로 사용할 커스텀 데이터 타입을 정의할 때, 이 앱 엔티티를 통해 시스템이 해당 타입을 이해하고, 적절한 값을 선택하거나 추천할 수 있도록 도와줍니다.

예를 들어, 사진 앱에서는 사진 자체뿐만 아니라 "가장 최근 사진", "기본 앨범"과 같은 특별한 엔티티도 정의할 수 있습니다. 이런 엔티티를 제공하면 사용자가 복잡한 명령 없이도 원하는 작업을 더 빠르고 쉽게 실행할 수 있습니다.

앱 엔티티를 만들 때는, 시스템에서 사용할 주요 데이터 타입과 개념을 중심으로 정의하고, 사용자가 쿼리로 검색할 때 도움이 되도록 필요한 속성(예: 앨범 이름 등)을 포함해야 합니다.

앱 데이터를 엔티티로 표현하는 방법이 궁금하다면, "사용자 지정 데이터 유형을 인텐트에 통합하기" 문서를 참고하세요.
> https://developer.apple.com/documentation/appintents/integrating-custom-types-into-your-intents