//
//  MusicControl.swift
//  SwiftUIDILabotary
//
//  Created by Greem on 4/7/25.
//

import Foundation

protocol MusicControlUseCase {
    init(repository: MusicControlRepository)
    func play()
    func pause()
    func getItems() -> [MusicItemID]
}
