//
//  screentimewidgetLiveActivity.swift
//  screentimewidget
//
//  Created by Daniil Ekzarian on 13/10/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct screentimewidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct screentimewidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: screentimewidgetAttributes.self) { context in
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

extension screentimewidgetAttributes {
    fileprivate static var preview: screentimewidgetAttributes {
        screentimewidgetAttributes(name: "World")
    }
}

extension screentimewidgetAttributes.ContentState {
    fileprivate static var smiley: screentimewidgetAttributes.ContentState {
        screentimewidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: screentimewidgetAttributes.ContentState {
         screentimewidgetAttributes.ContentState(emoji: "🤩")
     }
}

// NOTE: Fails to build on Expo
// #Preview("Notification", as: .content, using: screentimewidgetAttributes.preview) {
//    screentimewidgetLiveActivity()
// } contentStates: {
//     screentimewidgetAttributes.ContentState.smiley
//     screentimewidgetAttributes.ContentState.starEyes
// }
