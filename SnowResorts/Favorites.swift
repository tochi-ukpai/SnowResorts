//
//  Favorites.swift
//  SnowResorts
//
//  Created by Theós on 04/07/2023.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"

    init() {
        if let data = UserDefaults.standard.stringArray(forKey: saveKey) {
            resorts = Set(data)
            return
        }
        resorts = []
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        UserDefaults.standard.set(Array(resorts), forKey: saveKey)
    }
}
