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
            
            if (model.list.count == 0){
                Text("You haven't added any clothing yet").foregroundColor(.black).opacity(0.5).font(.title).padding()
            } else {
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(model.list, id: \.id) { item in
                    CardView(item: item)
                }
                
            }.padding().navigationBarTitle("All Items")}
                
        }.onAppear{model.getClothing()}
    }
    
}



