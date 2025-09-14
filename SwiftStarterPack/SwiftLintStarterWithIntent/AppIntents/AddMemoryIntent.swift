//
//  AddMemoryIntent.swift
//  SwiftLintStarterWithIntent
//
//  Created by Greem on 8/8/25.
//

import Foundation
import SwiftData
import AppIntents

struct AddMemoryIntent: AppIntent {
    
    //    @Parameter(
    //        title: .init(stringLiteral: "Choose a Image"),
    //        description: "The trail to get information on.",
    //        supportedContentTypes: [.image],
    //        inputConnectionBehavior: .connectToPreviousIntentResult
    //    )
    //    var imageFile: IntentFile
//    @Parameter(
//        title: .init(stringLiteral: "Input your text"),
//        description: "The trail to get information on.",
//        supportedContentTypes: [.plainText],
//        inputConnectionBehavior: .default
//    )
//    var textData: IntentFile
    @Parameter(title: "저장할 텍스트")
      var textToSave: String
    
    
    
    @Parameter(title: "Caption")
    var caption: String
    
    static var openAppWhenRun: Bool = true
    
    static var title: LocalizedStringResource = "Add New Memory"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        //        let container = try ModelContainer(for: Memory.self)
        //        let context = ModelContext(container)
        
        //        let imageData = try await imageFile.data(contentType: .image)
        //        let memory = Memory(caption: caption, date: .init(), imageData: imageData)
        
        //        context.insert(memory)
        //        try context.save()
//        let textData = try await textData.data(contentType: .plainText)
//        let text = String(data: textData, encoding: .utf8) ?? "없음"
//        return .result(dialog: "Memory added successfully!")
        return .result(dialog: .init(stringLiteral: textToSave))
    }
    
}
