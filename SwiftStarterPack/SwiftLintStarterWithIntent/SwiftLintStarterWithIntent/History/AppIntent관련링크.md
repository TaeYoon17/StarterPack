### App Intents for Apple ecosystem

https://dev.to/arshtechpro/app-intents-for-apple-ecosystem-3nek

## App Intents 개요
App Intents는 단순한 프레임워크가 아닌 **생태계**로, 앱의 기능을 Apple 시스템 전반에 확장할 수 있게 해줍니다.

### 통합 지점
- **Spotlight**: 검색 및 Mac 전체 액션 실행
- **Siri**: 음성 명령
- **Control Center**: 빠른 액세스 컨트롤
- **Widget**: 상호작용 경험
- **Action Button**: 상황 인식 경험
- **Apple Pencil Pro**: 커스텀 액션

## 핵심 아키텍처: 문법 시스템

### 문법 비유
- **Intents** = **동사** (액션: 노트 열기, 운동 시작, 장보기 아이템 추가)
- **App Enums/Entities** = **명사** (데이터: 네비게이션 섹션, 사용자 콘텐츠)
- **App Shortcuts** = **문장** (완전한 구문: intent + 매개변수)

### 빌드 타임 처리 아키텍처
- **소스 코드**: Swift 소스 코드가 진실의 원천
- **빌드 타임 생성**: 프레임워크가 코드를 읽어 App Intents 표현 생성
- **시스템 이해**: 앱을 실행하지 않고도 시스템이 기능을 이해
- **중요 제약**: 제목과 표현은 **상수 값**이어야 함 (함수/계산 프로퍼티 불가)

## 핵심 컴포넌트

### 1. 기본 Intent 구조
**최소 요구사항:**
- `title`: 고유한 LocalizedStringResource (고유 식별자가 됨)
- `perform()` 메서드: 로직 포함, IntentResult 반환
- UI 작업을 위한 `@MainActor` 사용
- 앱을 열고 실행하려면 `supportedModes: .foreground`

### 2. 매개변수 & App Enums
**App Enum 요구사항:**
- String raw value (문자열로부터 인스턴스 생성 가능)
- TypeDisplayRepresentation (전체 타입 설명)
- CaseDisplayRepresentation (각 케이스 설명)
- **컴파일 타임 상수 값만 허용**

### 3. App Entities (동적 데이터)
**Entity 요구사항:**
- **영구 식별자** (중요 - 조회 친화적이어야 함)
- `@Property` 또는 **새로운** `@ComputedProperty`를 가진 속성들
- 인스턴스를 위한 DisplayRepresentation
- 시스템 추론을 위한 연관된 EntityQuery

### 4. App Shortcuts (자동 발견)
**자동 시스템 노출:**
- Spotlight에서 주요하게 표시
- Siri 트리거 구문 (`applicationName` 플레이스홀더 포함 필수)
- Action Button/Apple Pencil 구성
- 사용자 설정 없이 Shortcuts 앱에서 사용

## 2024년 주요 업데이트

1. **Mac Spotlight 통합**: 시스템 전체 직접 액션 실행
2. **@ComputedProperty**: 모델 간 값 복사 제거
3. **Swift Package 지원**: 향상된 멀티 타겟 아키텍처
4. **직접 속성 인덱싱**: 개별 속성의 Spotlight 키
5. **TargetContentProvidingIntent**: perform() 메서드 없는 네비게이션

## 모범 사례

1. **작게 시작**: 핵심 기능을 위한 하나의 App Shortcut
2. **자연어**: 가독성을 위한 Parameter Summaries
3. **사용자 경험**: suggestedEntities 구현
4. **크로스 앱 통합**: 데이터 공유를 위한 Transferable 사용
5. **시스템 통합**: Spotlight 발견을 위한 IndexedEntity

## 일반적인 함정

- 비상수 빌드 타임 값 (제목, 표현)
- 멀티 타겟 앱에서 AppIntentsPackage 등록 누락
- 부적절한 EntityQuery 구현
- UI 작업을 위한 @MainActor 누락
- 부실한 entity ID 지속성 전략

## 시작 전략

1. 앱의 가장 중요한 액션 식별
2. 제목과 perform 메서드를 가진 기본 intent 생성
3. 즉시 발견 가능하도록 App Shortcut 추가
4. 자연어를 위한 Parameter Summary 구현
5. entities와 고급 쿼리로 확장
6. 발견을 위한 Spotlight 인덱싱 통합
7. 크로스 앱 기능을 위한 Transferable 지원 추가