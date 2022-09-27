//
//  DataController.swift
//  ElSanto
//
//  Created by Fede Garcia on 22/09/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Historial")
    
    init() {
        container.loadPersistentStores{ description , error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
            
    }}
}
