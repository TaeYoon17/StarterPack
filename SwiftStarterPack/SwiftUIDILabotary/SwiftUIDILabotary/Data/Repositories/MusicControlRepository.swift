//
//  MusicControlRepository.swift
//  SwiftUIDILabotary
//
//  Created by Greem on 4/7/25.
//

import Foundation

protocol MusicControlRepository{
    
    func fetchMusicLists() -> [String]
    
    func play()
    
}
