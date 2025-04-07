//
//  MusicControlRepositoryWithAppleMusic.swift
//  SwiftUIDILabotary
//
//  Created by Greem on 4/7/25.
//

import Foundation

final class MusicControlRepositoryWithAppleMusic: MusicControlRepository {
    
    let appleMusicService = AppleMusicService()
    let avfAudioService = AVFAudioService()
    
    func fetchMusicLists() -> [String] {
        ["a", "b", "c", "d"]
    }
    
    func play() {
        //        audio.play()
    }
}
