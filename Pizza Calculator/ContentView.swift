//
//  ContentView.swift
//  Pizza Calculator
//
//  Created by Michal Duda on 26/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            PizzaCalculator().tabItem {
                Image(systemName: "circle.circle")
                Text("Pizza")
            }
            PeopleList().tabItem {
                Image(systemName: "person.3.fill")
                Text("Osoby")
            }
            
            InfoScreen().tabItem {
                Image(systemName: "info.circle.fill")
                Text("About")
            }
            
        }
        .edgesIgnoringSafeArea(.top)
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 mini")
    }
}
