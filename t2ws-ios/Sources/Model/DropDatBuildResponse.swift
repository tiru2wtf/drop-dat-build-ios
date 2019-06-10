//
//  DropDatBuildResponse.swift
//  t2ws-ios
//
//  Created by Bruno Alves on 08/06/19.
//  Copyright © 2019 t2ws. All rights reserved.
//

import Foundation

struct dropDatBuild: Codable {
    let musicas: [Musica]
}

struct Musica: Codable {
    let tocando: [Tocando]
}

struct Tocando: Codable {
    let singer, song: String
}
