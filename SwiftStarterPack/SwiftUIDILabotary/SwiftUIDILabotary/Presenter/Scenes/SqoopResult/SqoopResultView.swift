//
//  SqoopResultView.swift
//  SwiftUIDILabotary
//
//  Created by Greem on 4/7/25.
//

import SwiftUI

struct SqoopResultAppleMusicView: View {
    @Environment(MusicPlaylistViewModel.self) var viewModel
    var body: some View {
        Text("Sqoop Result View")
    }
}

#Preview {
    SqoopResultAppleMusicView().environment(
        MusicPlaylistViewModelFactory.getByPlatformType(.apple)
    )
}
