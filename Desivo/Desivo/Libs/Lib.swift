//
//  Lib.swift
//  Desivo
//
//  Created by Иван Дмитриев on 10.05.2024.
//

import Foundation


struct Room: Identifiable {
    var id = UUID()
    var name: String
    var temperature: Int
    var devices: Int
    var imageName: String
}

struct Sensors: Identifiable {
    var id = UUID()
    var name: String
    var type: String
}

struct Categories: Identifiable {
    var id = UUID()
    let name = "Temperature"
    var meaning: Int
    var imageName: String
}

struct Accessory: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}
