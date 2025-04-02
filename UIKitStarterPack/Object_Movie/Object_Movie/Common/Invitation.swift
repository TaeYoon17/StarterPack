//
//  Invitation.swift
//  Object_Movie
//
//  Created by Greem on 4/2/25.
//

import Foundation

class Invitation {
    weak var theater: Theater!
    init(_ theater: Theater) {
        self.theater = theater
    }
}
