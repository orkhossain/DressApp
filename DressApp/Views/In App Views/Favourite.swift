//
//  Favourite.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 09/11/2021.
//

import SwiftUI
import Firebase

struct Favourite: View {
    
    @State private var currentFavouriteList: Int = 0
    @ObservedObject private var model = ClothViewModel()
    @ObservedObject private var OutfitModel = OutfitViewModel()
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        
        NavigationView{
            
            VStack(alignment:.leading){
                
                HStack{
                    Button(action: {
                    
                    currentFavouriteList = 0
                    
                }) {
                    Text("Cloths")
                        .padding(.vertical,6)
                        .padding(.horizontal,10)
                        .background(currentFavouriteList == 0 ? Color.blue : Color.clear)
                        .clipShape(Capsule())
                }
                .foregroundColor(currentFavouriteList == 0 ? .white : .blue)
                    
                    Button(action: {
                        currentFavouriteList = 1
                    }) {
                        Text("Outfits")
                            .padding(.vertical,6)
                            .padding(.horizontal,10)
                            .background(currentFavouriteList == 1 ? Color.blue : Color.clear)
                            .clipShape(Capsule())
                    }
                    .foregroundColor(currentFavouriteList == 1 ? .white : .blue)
                    
                
                }.padding()
                
                
                
                if currentFavouriteList == 0
                {
                    
                    
                    ScrollView {
                        
                        if (model.favouriteList.count == 0){
                            Text("You don't have favourite clothing yet").font(.title).padding()
                        } else {
                            
                            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                                
                                ForEach(model.favouriteList){ item in
                                    
                                    CardView(item: item)
                                }
                                
                            }.padding()
                            
                        }
                    }
                    
                    
                    
                }
                
                else{
                    
                    ScrollView {
                        if (OutfitModel.favouriteList.count == 0){
                            Text("You don't have any favourite outfit yet").font(.title).padding()
                        } else {
                            
                            LazyVGrid(columns: gridItemLayout) {
                                ForEach(OutfitModel.favouriteList, id: \.id) { item in
                                    let items = Array(Array(item.Clothing.values).prefix(4))
                                    VStack{
                                        Spacer()
                                        NavigationLink(
                                            destination: OutfitView(Outfit: item),
                                            label: {
                                                VStack(alignment:.center){
                                                    Folder(outfitImages: items)}
                                            }
                                            
                                        ).frame(width: 140, height: 180, alignment: .leading)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(Color.gray, lineWidth: 1)
                                            )
                                        
                                    }
                                }
                            }
                            
                        }
                        
                        
                        
                        
                    }.padding()
                }
                
                
                
                
            }.navigationBarTitle("Favourite", displayMode:.large)
                .onAppear{
                    model.getFavourite()
                    OutfitModel.getFavourite()
                }.navigationViewStyle(.stack)
            
            
        }
    }
    
    
}
