//
//  AddPersonView.swift
//  Pizza Calculator
//
//  Created by Michal Duda on 01/05/2022.
//

import AlertToast
import SwiftUI

struct AddPersonView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var pieces = ""
    
    let piecesPicker = ["1", "2", "3", "4", "5"]
    
    @State private var showError = false
    
    var body: some View {
        
        
        
        
        NavigationView {
            Form {
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Imię")
                            .fontWeight(.medium)
                        TextField("Steve", text: $name)
                    }
                    .padding(.bottom, 5.0)
                    
                    
                    
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
                    
                    
                    
                }
                
                
                Section {
                    
                    VStack(alignment: .leading) {
                        Button("Zapisz") {
                            
                            if (name == "" || pieces == ""){
                                showError = true
                            }
                            
                            else{
                                let newPerson = People(context: moc)
                                newPerson.id = UUID()
                                newPerson.name = name
                                newPerson.pieces = pieces
                                
                                
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

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
