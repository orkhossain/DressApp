//
//  CategoryView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 24/11/2021.
//

import SwiftUI
import Firebase

struct CategoryView: View {
    
    @ObservedObject var ClothModel = ClothViewModel()
    public var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @State public var category:String
    
    var body: some View {
        ScrollView {
            
            if (ClothModel.categoryList.count == 0){
                Text("You haven't added \(category) yet").font(.title).padding()
            }
            else{
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(ClothModel.categoryList, id: \.id) { item in
                    CardView(item: item).navigationBarTitle("\(item.Item)s")
                }
            }.padding()}
            
        }.onAppear{ClothModel.getSpecificItem(Category: category)}
    }
    
    
    
}

