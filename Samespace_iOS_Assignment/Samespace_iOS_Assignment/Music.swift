//
//  Music.swift
//  Samespace_iOS_Assignment
//
//  Created by Prasenjeet Pandagale on 05/04/24.
//

import Foundation
struct Response {
    var data: [Song]
}

struct Song {
    var id: Int
    var name: String
    var artist: String
    var top_track: Bool
    var url: String
}


