//
//  AddPizzaView.swift
//  Pizza Calculator
//
//  Created by Michal Duda on 26/04/2022.
//

import AlertToast
import SwiftUI

struct AddPizzaView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var pieces = ""
    @State private var diameter = ""
    @State private var price = ""
    
    
    let diameterPicker = ["30", "40", "50"]
    let piecesPicker = ["1", "2", "3", "4", "5","7","8"]
    
    @State private var showError = false
    
    var body: some View {
        
        
        
        
        NavigationView {
            Form {
                
                //                Section{
                //                    if(showError == true){
                //
                //                        HStack {
                //                            Image(systemName: "xmark.octagon.fill")
                //                                .resizable()
                //                                .frame(width: 25.0, height: 25.0)
                //                                .foregroundColor(Color.red)
                //
                //                            Text("Wypełnij wszystkie pola!")
                //                                .fontWeight(.medium)
                //                            .foregroundColor(Color.red)
                ////                            .animation(.easeIn(duration: 2))
                //                            .task(delayText)
                //                        }
                //
                //
                //                    }
                //
                //                }
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Nazwa pizzy")
                            .fontWeight(.medium)
                        TextField("Pepperoni", text: $name)
                    }
                    .padding(.bottom, 5.0)
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Średnica")
                            .fontWeight(.medium)
                        HStack {
                            Picker("Średnica", selection: $diameter) {
                                ForEach(diameterPicker, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            Text("cm")
                        }
                        
                    }
                    .padding(.vertical, 5.0)
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ilość kawałków")
                            .fontWeight(.medium)
                        Picker("Ilość kawałków", selection: $pieces) {
                            ForEach(piecesPicker, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                    }
                    .padding(.vertical, 5.0)
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Cena")
                            .fontWeight(.medium)
                        HStack {
                            TextField("35.43", text: $price)
                                .keyboardType(.numbersAndPunctuation)
                                .frame(width: 45)
                            Text("zł")
                            Spacer()
                        }
                        
                    }
                    .padding(.top, 5.0)
                    
                    
                }
                
                
                Section {
                    
                    VStack(alignment: .leading) {
                        Button("Zapisz") {
                            
                            if (name == "" || pieces == "" || diameter == "" || price == "" ){
                                showError = true
                            }
                            
                            else{
                                let newPizza = Pizza(context: moc)
                                newPizza.id = UUID()
                                newPizza.name = name
                                newPizza.pieces = pieces
                                newPizza.diameter = diameter
                                newPizza.price = price
                                
                                try? moc.save()
                                dismiss()
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("Nowa pizza")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Rectangle()
                        .frame(width: 40, height: 5)
                        .cornerRadius(3)
                        .opacity(0.2)
                    
                }
            }
            .toast(isPresenting: $showError){
                AlertToast(type: .error(Color.red), title: "Nie wprowadzono wszystkich danych")
            }
            
            //            .navigationBarItems(leading: Rectangle()
            //                .frame(width: 40, height: 5)
            //                .cornerRadius(3)
            //                .opacity(0.2))
            
        }
    }
    
    private func delayText() async {
        // 1 second = 1_000_000_000 nanoseconds
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        showError = false
        
    }
    
    
}



struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddPizzaView()
    }
}
