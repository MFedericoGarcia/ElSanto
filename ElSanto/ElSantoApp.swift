//
//  ElSantoApp.swift
//  ElSanto
//
//  Created by Fede Garcia on 16/08/2022.
//

import SwiftUI

@main
struct ElSantoApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
