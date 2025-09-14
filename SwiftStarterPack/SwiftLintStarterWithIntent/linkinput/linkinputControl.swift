//
//  linkinputControl.swift
//  linkinput
//
//  Created by Greem on 8/8/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import AppIntents
import SwiftUI
import WidgetKit

struct linkinputControl: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.arpple.tistory.SwiftLintStarterWithIntent.linkinput"
        ) {
            ControlWidgetButton(action: MyIntent()) {
                Label("On", systemImage: "timer")
            }
//            ControlWidgetToggle(
//                "Start Timer",
//                isOn: value,
//                action: StartTimerIntent()
//            ) { isRunning in
//                Label(isRunning ? "On" : "Off", systemImage: "timer")
//            }
        }
        .displayName("Test")
        .description("A an example control that runs a timer.")
    }
}


struct DefaultIntent: AppIntent  {
    static let title: LocalizedStringResource = "Start a timer"
    
    @Parameter(title: "텍스트 받아보자...")
    var value: Bool
    
    static var openAppWhenRun = true
    func perform() async throws -> some IntentResult & ProvidesDialog {
        // Start / stop the timer based on `value`.
        return  .result(dialog: .init(stringLiteral: "잘 나타나용"))
    }
}


struct StartTimerIntent: SetValueIntent  {
    static let title: LocalizedStringResource = "Start a timer"

    @Parameter(title: "Timer is running")
    var value: Bool

    func perform() async throws -> some IntentResult & ProvidesDialog {
        // Start / stop the timer based on `value`.
        return  .result(dialog: .init(stringLiteral: "잘 나타나용"))
    }
}


extension linkinputControl {
    struct Provider: ControlValueProvider {
        var previewValue: Bool {
            false
        }

        func currentValue() async throws -> Bool {
            let isRunning = true // Check if the timer is running
            return isRunning
        }
    }
}

