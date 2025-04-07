//
//  MusicPlaylistViewModelFactory.swift
//  SwiftUIDILabotary
//
//  Created by Greem on 4/7/25.
//

import Foundation

class MusicPlaylistViewModelFactory {
    
    enum MusicType {
        case apple
        case spotify
        case youtube
    }
    
    static func getByPlatformType(_ type: MusicType) -> MusicPlaylistViewModel {
        switch type {
        case .apple:
            MusicPlaylistViewModel(
                useCase: MusicControlUseCaseImpl(
                    repository: MusicControlRepositoryWithAppleMusic()
                )
            )
        case .spotify:
            MusicPlaylistViewModel(
                useCase: MusicControlUseCaseImpl(
                    repository: MusicControlRepositoryWithSpotify()
                )
            )
        case .youtube:
            MusicPlaylistViewModel(
                useCase: MusicControlUseCaseImpl(
                    repository: MusicControlRepositoryWithYoutube()
                )
            )
        }
    }
    
}
