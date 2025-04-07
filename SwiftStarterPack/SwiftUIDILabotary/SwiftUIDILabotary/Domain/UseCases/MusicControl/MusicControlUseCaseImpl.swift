//
//  MusicControlUseCaseImpl.swift
//  SwiftUIDILabotary
//
//  Created by Greem on 4/7/25.
//

import Foundation

final class MusicControlUseCaseImpl: MusicControlUseCase {
    let repository:MusicControlRepository
    
    required init(repository: any MusicControlRepository) {
        self.repository = repository
    }
    
    func play() {
        
    }
    
    func pause() {
        
    }
    
    func getItems() -> [MusicItemID] {
        []
    }
}
