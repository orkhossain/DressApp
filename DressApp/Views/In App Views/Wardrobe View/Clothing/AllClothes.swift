//
//  ClothesView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 23/11/2021.
//


import SwiftUI
import Firebase

struct ClothesView: View {
    
    @ObservedObject var ClothModel = ClothViewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            
            if (ClothModel.list.count == 0){
                Text("You haven't added any clothing yet").font(.title).padding()
            } else {
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(ClothModel.list, id: \.id) { item in
                    CardView(item: item)
                }
                
            }.padding().navigationBarTitle("All Items")}
                
        }.onAppear{ClothModel.getClothing()}
    }
    
}



