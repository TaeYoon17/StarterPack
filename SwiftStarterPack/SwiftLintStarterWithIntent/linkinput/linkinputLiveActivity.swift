//
//  linkinputLiveActivity.swift
//  linkinput
//
//  Created by Greem on 8/8/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct linkinputAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct linkinputLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: linkinputAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension linkinputAttributes {
    fileprivate static var preview: linkinputAttributes {
        linkinputAttributes(name: "World")
    }
}

extension linkinputAttributes.ContentState {
    fileprivate static var smiley: linkinputAttributes.ContentState {
        linkinputAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: linkinputAttributes.ContentState {
         linkinputAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: linkinputAttributes.preview) {
   linkinputLiveActivity()
} contentStates: {
    linkinputAttributes.ContentState.smiley
    linkinputAttributes.ContentState.starEyes
}
