//
//  SqoopResultViewModel.swift
//  SwiftUIDILabotary
//
//  Created by Greem on 4/6/25.
//

import Foundation
import MusicKit

@Observable
final class MusicPlaylistViewModel {
    @ObservationIgnored let musicControlUseCase: MusicControlUseCase
    var musicItems: [MusicItemID]
    
    
    
    init(useCase: MusicControlUseCase) {
        self.musicControlUseCase = useCase
        self.musicItems = useCase.getItems()
    }
    
}


