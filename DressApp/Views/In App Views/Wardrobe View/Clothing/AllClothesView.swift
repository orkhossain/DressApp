//
//  ClothesView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 23/11/2021.
//


import SwiftUI
import Firebase

struct ClothesView: View {
    
    @ObservedObject var model = ClothviewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
            ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(model.list, id: \.id) { item in
                    CardView(item: item)
            }
            
            }.navigationBarTitle("All Items").onAppear{model.getClothing()}}.padding()
    }
    
}



