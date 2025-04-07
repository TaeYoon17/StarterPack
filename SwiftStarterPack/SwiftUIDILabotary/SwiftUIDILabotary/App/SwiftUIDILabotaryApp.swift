//
//  SwiftUIDILabotaryApp.swift
//  SwiftUIDILabotary
//
//  Created by Greem on 4/6/25.
//

import SwiftUI

@main
struct SwiftUIDILabotaryApp: App {
    var body: some Scene {
        WindowGroup {
            SqoopResultAppleMusicView()
                .environment(
                    MusicPlaylistViewModelFactory.getByPlatformType(.apple)
                )
        }
    }
}
