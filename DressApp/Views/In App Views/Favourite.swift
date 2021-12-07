//
//  Favourite.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 09/11/2021.
//

import SwiftUI
import Firebase

struct Favourite: View {
    
    @ObservedObject private var model = ClothviewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            Text(" Your favourite items").font(.title).bold()
                .padding(.top,15)
                .padding(.leading, 5)
            
            ScrollView {
                Spacer()
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach(model.favouriteList, id: \.id) { item in
                        VStack{
                            
                            VStack{NavigationLink(
                                destination:
                                    ClothView(item: item),
                                label: {
                                    VStack(alignment:.center){
                                        Text("Description: \(item.Event)")
                                        Text("Colour: \(item.Colour)")}
                                }
                                
                            )
                                
                            }.padding()
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
                            }
                        }
                    }
                }
                
            }.onAppear{model.getFavourite()}.navigationBarTitle("").navigationBarHidden(true)
        }
    }
}


