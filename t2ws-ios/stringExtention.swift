//
//  stringExtention.swift
//  t2ws-ios
//
//  Created by Bruno Alves on 10/06/19.
//  Copyright © 2019 t2ws. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
