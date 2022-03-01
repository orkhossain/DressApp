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
        NavigationView{
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach(model.favouriteList, id: \.id) { item in
                        
                        
                        VStack{
                            Spacer()
                            Spacer()
                            VStack{
                                NavigationLink(
                                destination:
                                    ClothView(item: item),
                                label: {
                                    VStack(alignment:.center){
                                        Text("Description: \(item.Event)")
                                        Text("Colour: \(item.Colour)")
                                        Spacer()
                                        HStack{
                                            Text("\(item.Item)")
                                            Spacer()
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
                                
                            )
                                
                            }.padding()
                                .frame(width: 160, height: 200, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                    }
                }.padding()
                
            }.navigationBarTitle("Favourites",displayMode: .automatic)
        }.onAppear{model.getFavourite()}
    }
}


