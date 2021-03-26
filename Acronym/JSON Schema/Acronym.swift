//
//  Acronym.swift
//  Acronym
//
//  Created by Andres Marin on 26/03/21.
//

import Foundation

struct Acronym: Codable {
    var sf: String?
    var lfs: [LF]?
}

struct LF: Codable {
    var lf: String?
    var freq: Int?
    var since: Int?
    var vars: [VARS]?
}

struct VARS: Codable {
    var lf: String?
    var freq: Int?
    var since: Int?
}


