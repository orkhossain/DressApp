//
//  SuggestOutfit.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import SwiftUI
import Firebase

struct SuggestOutfit: View {
    
    @ObservedObject private var ClothModel = ClothviewModel()
    @ObservedObject private var OutfitModel = OutfitViewModel()
    @State private var genreatedOutfit = []

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).onAppear{
            ClothModel.getClothing()}
    }
    
    
    
//
//    func generateOutfit(){
//        ForEach(ClothModel.list, id: \.id){ item in
//            genreatedOutfit.append(item)
//
//        }
//    }
}

