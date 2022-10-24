//
//  Pizza_CalculatorApp.swift
//  Pizza Calculator
//
//  Created by Michal Duda on 26/04/2022.
//

import SwiftUI

@main
struct Pizza_CalculatorApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
