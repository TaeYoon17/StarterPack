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
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Memories")
    }
}


#Preview {
    ContentView()
}


/// 앱 인텐트가 이미지 파일과 캡션 텍스트와 관련된 파라미터를 가져오도록 할 것
/// This App-Intent can be added to any shortcut creation while creating a new shortcut from the Shortcuts app.
/// => 사용자가 새로운 단축어를 만들 때, 이 App-Intent를 그 단축어에 포함할 수 있다.

struct AddMemoryIntent: AppIntent {
    
    @Parameter(
        title: .init(stringLiteral: "Choose a Image"),
        description: "The trail to get information on.",
        supportedContentTypes: [.image],
        inputConnectionBehavior: .connectToPreviousIntentResult
    ) var imageFile: IntentFile
    
    @Parameter(title: "Caption") var caption: String
    
    
    static var title: LocalizedStringResource = "Add New Memory"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
    
}
