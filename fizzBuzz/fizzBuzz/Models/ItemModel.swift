//
//  ItemModel.swift
//  FizzBuzz
//
//  Created by Mohamed Ali BELHADJ on 24/9/2022.
//

import Foundation

struct Item: Identifiable {
    var id = UUID()
    let description: String
    
    init(id: UUID = UUID(), description: String) {
        self.id = id
        self.description = description
    }
}


