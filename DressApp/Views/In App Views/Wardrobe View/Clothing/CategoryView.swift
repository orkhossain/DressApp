//
//  CategoryView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 24/11/2021.
//

import SwiftUI
import Firebase

struct CategoryView: View {
    
    @ObservedObject var model = ClothviewModel()
    public var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @State public var category:String
    
    var body: some View {
        ScrollView {
            
            if (model.categoryList.count == 0){
                Text("You haven't added \(category) yet").font(.title).padding()
            }
            else{
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(model.categoryList, id: \.id) { item in
                    CardView(item: item).navigationBarTitle("\(item.Item)s")
                }
            }.padding()}
            
        }.onAppear{model.getSpecificItem(Category: category)}
    }
    
    
    
}

