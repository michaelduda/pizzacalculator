//
//  PizzaCalculator.swift
//  Pizza Calculator
//
//  Created by Michal Duda on 01/05/2022.
//

import SwiftUI

struct PizzaCalculator: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var pizzas: FetchedResults<Pizza>
    
    @State private var showingAddScreen = false
    
    
    var body: some View {
        
        //ilość kawałków
        let pieces = pizzas.map {$0.pieces ?? "0"}
        let intPieces = pieces.map{Int($0) ?? 0}
        let totalPieces = intPieces.reduce(0, +)
        let totalPiecesDouble = Double(totalPieces)
        //
        
        //suma cen
        let prices = pizzas.map {$0.price ?? "0.00"}
        let doublePrices = prices.map{Double($0) ?? 0}
        let totalPrices = doublePrices.reduce(0, +)
        let totalPricesString = String(format: "%.02f zł", totalPrices)
        
        //
        
        // cena za kawałek
        let slicePrice = totalPrices / totalPiecesDouble
        let slicePriceString = slicePrice.isNaN ? "0.00 zł" : String(format: "%.02f zł", slicePrice)
        
        
        NavigationView {
            
            List{
                
                
                if (pizzas.count == 0){
                    VStack(alignment: .leading) {
                        Text("Brak danych")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                            .padding(.bottom, 5)
                        Text("Dodaj nową pizzę.")
                    }
                }
                
                else {
                    ForEach(pizzas){ pizza in
                        
                        Section(header: Text("\(pizza.name ?? "🍕")")) {
                            
                            VStack {
                                
                                HStack {
                                    Text("Średnica")
                                    Spacer()
                                    Text(pizza.diameter ?? "brak średnicy")
                                        .multilineTextAlignment(.trailing)
                                }
                                HStack {
                                    Text("Ilość kawałków")
                                    Spacer()
                                    Text(pizza.pieces ?? "brak ilości kawałków")
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("Cena")
                                    Spacer()
                                    Text(pizza.price ?? "brak ceny")
                                        .multilineTextAlignment(.trailing)
                                }
                                
                            }
                            
                            
                        }
                        
                    }
                    .onDelete(perform: deletePizza)
                    //                        .onMove { (source: IndexSet, destination: Int) in
                    //                            self.pizzas.move(fromOffsets: source, toOffset: destination)
                    //                        }
                    
                    Section(header: Text("Podsumowanie")){
                        HStack {
                            Text("Łączna ilość pizz")
                            Spacer()
                            
                            if (pizzas.count > 4) {
                                Text("\(pizzas.count)")
                                    .foregroundColor(Color.red)
                            }
                            else {
                                Text("\(pizzas.count)")
                            }
                            //                                .fontWeight(.semibold)
                            
                        }
                        
                        if (pizzas.count > 4) {
                            
                            HStack {
                                Spacer()
                                Text("jest grubo 😎 ↑")
                            }
                        }
                        
                        
                        HStack {
                            Text("Łączna ilość kawałków")
                            Spacer()
                            Text("\(totalPieces)")
                            //                                .fontWeight(.semibold)
                        }
                        
                        HStack {
                            Text("Łączna cena")
                            Spacer()
                            Text("\(totalPricesString)")
                            //                                .fontWeight(.semibold)
                        }
                        
                        
                        HStack {
                            Text("Cena za kawałek")
                            Spacer()
                            Text("\(slicePriceString)")
                            //                                .fontWeight(.semibold)
                        }
                    }
                    
                }
                
            }
            
            .navigationTitle("Kalkulator Pizzy 🍕")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        
                        Label("Add Book", systemImage: "plus")
                        
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddPizzaView()
            }
        }
    }
    
    func deletePizza (at offsets: IndexSet) {
        for offset in offsets {
            let pizza = pizzas[offset]
            moc.delete(pizza)
        }
        
    }
}

struct PizzaCalculator_Previews: PreviewProvider {
    static var previews: some View {
        PizzaCalculator()
    }
}
