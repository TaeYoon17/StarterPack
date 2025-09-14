//
//  MyIntent.swift
//  SwiftLintStarterWithIntent
//
//  Created by Greem on 8/8/25.
//

import AppIntents
import SwiftUI
import WidgetKit

struct MyIntent: AppIntent {
    static let title: LocalizedStringResource = "My Intent"
    static var openAppWhenRun: Bool = false

    init() {}

    @MainActor
    func perform() async throws -> some IntentResult & OpensIntent {
        
//        EnvironmentValues().openURL(urll)
//        return .result(dialog: .init("Hello, World!"))
        return .result(opensIntent: AddMemoryIntent())
//            .result(opensIntent: AddMemoryIntent())
    }
}
