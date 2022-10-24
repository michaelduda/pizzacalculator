//
//  PeopleList.swift
//  Pizza Calculator
//
//  Created by Michal Duda on 01/05/2022.
//

import SwiftUI

struct PeopleList: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var pizzas: FetchedResults<Pizza>
    @FetchRequest(sortDescriptors: []) var people: FetchedResults<People>
    
    @State private var showingAddScreen = false
    
    
    var body: some View {
        
        //tutaj trzeba ogarnąć żeby suma cen była zaciągana z TabBar lub jakiegoś innego wspólnego widoku.
        
        //łączna ilość kawałków pizzy
        let pieces = pizzas.map {$0.pieces ?? "0"}
        let intPieces = pieces.map{Int($0) ?? 0}
        let totalPieces = intPieces.reduce(0, +)
        let totalPiecesDouble = Double(totalPieces)
        //
        
        //suma cen
        let prices = pizzas.map {$0.price ?? "0.00"}
        let doublePrices = prices.map{Double($0) ?? 0}
        let totalPrices = doublePrices.reduce(0, +)
        
        //
        
        // cena za kawałek
        
        let slicePrice = totalPrices / totalPiecesDouble
        //
        
        //suma kawałków zabranych przez osoby
        
        let piecesPersons = people.map {$0.pieces ?? "0"}
        let doublePiecesPersons = piecesPersons.map{Int($0) ?? 0}
        let totalPiecesPersons = doublePiecesPersons.reduce(0, +)
        //        let totalPiecesPersonsDouble = Double(totalPiecesPersons)
        
        
        //
        
        VStack  {
            NavigationView {
                
                List {
                    if (people.count == 0) {
                        
                        VStack(alignment: .leading) {
                            Text("Brak danych")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                .padding(.bottom, 5)
                            Text("Dodaj nową osobę.")
                        }
                    }
                    
                    else {
                        ForEach(people) { person in
                            
                            
                            Section(header: Text(person.name ?? "Brak imienia")){
                                VStack{
                                    
                                    
                                    HStack {
                                        Text("Ile kawałkow")
                                        Spacer()
                                        Text(person.pieces ?? "brak ilości kawałków")
                                            .multilineTextAlignment(.trailing)
                                    }
                                    
                                    HStack{
                                        Text("Ile płaci")
                                        Spacer()
                                        
                                        Text("\(slicePrice.isNaN ? "0.00 zł" : String(format: "%.02f zł", slicePrice * (Double(person.pieces ?? "0") ?? 0)))")
                                            .multilineTextAlignment(.trailing)
                                    }
                                    
                                }
                                
                            }
                        }
                        
                        .onDelete(perform: deletePerson)
                        
                        Section(header: Text("Podsumowanie")){
                            HStack {
                                Text("Łączna ilość kawałków")
                                Spacer()
                                Text("\(totalPiecesPersons)")
                            }
                            HStack {
                                if ((totalPieces - totalPiecesPersons) >= 0) {
                                    Text("Kawałki do wydania")
                                    Spacer()
                                    Text("\(totalPieces - totalPiecesPersons)")
                                }
                                
                                else {
                                    VStack {
                                        HStack {
                                            Text("Za dużo kawałków!")
                                                .foregroundColor(Color.red)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Liczba kawałków do odjęcia")
                                            Spacer()
                                            Text("\(totalPiecesPersons - totalPieces)")
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                    }
                }
                
                
                .navigationTitle("Lista osób 👽")
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                        
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            
                            Label("Add person", systemImage: "plus")
                            
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    
                    AddPersonView()
                    
                    
                }
                
                
            }
            
            
            
        }
        
    }
    
    func deletePerson (at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            moc.delete(person)
        }
        
    }
    
}

struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}
