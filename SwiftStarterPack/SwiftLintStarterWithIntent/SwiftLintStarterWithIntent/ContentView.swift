//
//  ContentView.swift
//  SwiftLintStarterWithIntent
//
//  Created by Greem on 4/8/25.
//

import SwiftUI
import SwiftData
import AppIntents

@Model
class Memory {
    
    var caption: String
    var date: Date
    
    @Attribute(.externalStorage)
    var imageData: Data
    
    init(caption: String, date: Date, imageData: Data) {
        self.caption = caption
        self.date = date
        self.imageData = imageData
    }
    var uiImage: UIImage? {
        .init(data: imageData)
    }
}

struct ContentView: View {
    @Query(sort: [.init(\Memory.date, order: .reverse)], animation: .smooth)
    var memories: [Memory]
    
    init() {
        AddMemoryShortcut.updateAppShortcutParameters()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memories) { memory in
                    Section(memory.caption) {
                        if let uiImage = memory.uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Memories")
            .safeAreaInset(edge: .bottom) {
            }
            
            //            Button(intent: PlayMusicIntent()() {
            //                Text("음악 선택하기")
            //            }
        }
    }
}

#Preview {
    ContentView()
}

/// 앱 인텐트가 이미지 파일과 캡션 텍스트와 관련된 파라미터를 가져오도록 할 것
/// This App-Intent can be added to any shortcut creation while
/// creating a new shortcut from the Shortcuts app.
/// => 사용자가 새로운 단축어를 만들 때, 이 App-Intent를 그 단축어에 포함할 수 있다.

struct AddMemoryShortcut: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] = [
        AppShortcut(
            intent: AddMemoryIntent(),
            phrases: [
                "Create a new \(.applicationName) memory"
            ],
            shortTitle: "Creat New Memory",
            systemImageName: "memories"
        ),
        // PlayMusicIntent의 genre 파라미터(MusicGenre)를 특정 값으로 넘기고 싶다면,
        // intent 생성 시 파라미터를 명시적으로 지정하면 됩니다.
        // 예시: genre에 .rock을 넘기고 싶을 때
    ]
}


/* 제어센터에서 열어 줄 수 있는 역할을 하는 것 같다...
 struct SelectFocusIntent: ControlConfigurationIntent {
 static let title: LocalizedStringResource = "Select Focus"
 static let description: IntentDescription = "Turn Focus on to silence notifications and filter out distractions."
 
 
 struct FocusOptionsProvider: DynamicOptionsProvider {
 
 func results() async throws -> [Focus] {
 FocusManager.shared.allFocuses
 }
 }
 
 
 @Parameter(title: "Focus", default: .doNotDisturb, optionsProvider: FocusOptionsProvider())
 var focus: Focus
 }
 */
