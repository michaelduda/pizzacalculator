//
//  CalculatorData.swift
//  Pizza Calculator
//
//  Created by Michal Duda on 27/04/2022.
//

//import SwiftUI
//import Foundation

//class CalculatorData: ObservableObject {
//
//
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var pizzas: FetchedResults<Pizza>
//
//
//    //ilość kawałków
//    lazy var pieces = pizzas.map {$0.pieces ?? "0"}
//    lazy var intPieces = pieces.map{Int($0) ?? 0}
//    lazy var totalPieces = intPieces.reduce(0, +)
//    lazy var totalPiecesDouble = Double(totalPieces)
//    //
//
//    //suma cen
//    lazy var prices = pizzas.map {$0.price ?? "0.00"}
//    lazy var doublePrices = prices.map{Double($0) ?? 0}
//    lazy var totalPrices = doublePrices.reduce(0, +)
//    lazy var totalPricesString = String(format: "%.02f zł", totalPrices)
//
//    //
//
//    // cena za kawałek
//    lazy var slicePrice = totalPrices / totalPiecesDouble
//    lazy var slicePriceString = slicePrice.isNaN ? "0.00 zł" : String(format: "%.02f zł", slicePrice)
//    
//
//
//// lazy var - ładuje zmienną tylko gdy jest wywołana
//
//  
//
//}



