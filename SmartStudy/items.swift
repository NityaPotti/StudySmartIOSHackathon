//
//  items.swift
//  SmartStudy
//
//  Created by Nitya Potti on 10/20/24.
//

import Foundation

struct Item: Codable, Identifiable {
    let id: String
    let title: String
    var isDone: Bool
    
    mutating func setDone(state: Bool) {
        isDone = state
    }
}
