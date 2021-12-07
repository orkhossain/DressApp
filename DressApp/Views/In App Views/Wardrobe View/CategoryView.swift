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
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(model.categoryList, id: \.id) { item in
                    VStack{
                        Spacer()
                        NavigationLink(
                            destination:
                                ClothView(item: item),
                            label: {
                                VStack(alignment:.center){
                            Text("Description: \(item.Event)")
                            Text("Colour: \(item.Colour)")}
                            }
                            
                        ).padding()
                            .frame(width: 160, height: 200, alignment: .leading)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        
                        HStack{
                            Text("\(item.Item)")
                            
                            Button {
                                model.setFavourite(item: item)
                            } label: {
                                if (item.Favourite == false) {
                                    Image(systemName: "heart")}
                                else {Image(systemName: "heart.fill")}
                            }
                        }                    }
                }
            }.navigationBarTitle("", displayMode: .inline)
            
        }.onAppear{model.getSpecificItem(Category: category)}
    }
    

       
}

