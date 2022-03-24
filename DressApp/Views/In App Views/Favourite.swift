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
    @ObservedObject private var model = ClothviewModel()
    @ObservedObject private var OutfitModel = OutfitViewModel()
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                
                HStack{
                    
                    Button(action: {
                        
                        currentFavouriteList = 0
                        
                    }) {
                        Text("Clothings")
//                        Image("msg")
//                            .resizable()
//                            .frame(width: 25, height: 25)
                            .padding(.vertical,12)
                            .padding(.horizontal,30)
                            .background(currentFavouriteList == 0 ? Color.white : Color.clear)
                            .clipShape(Capsule())
                    }
                    .foregroundColor(currentFavouriteList == 0 ? .pink : .white)
                    
                    Button(action: {
                        
                        currentFavouriteList = 1
                        
                    }) {
                        Text("Outfits")

                        .padding(.vertical,12)
                        .padding(.horizontal,30)
                        .background(currentFavouriteList == 1 ? Color.white : Color.clear)
                        .clipShape(Capsule())
                    }
                    .foregroundColor(currentFavouriteList == 1 ? .pink : .white)
                    
                    }.padding(3)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .frame(width: UIScreen.main.bounds.width - 20, height: 25)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                
                
                
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
                                VStack{
                                    Spacer()
                                    NavigationLink(
                                        destination: OutfitView(Outfit: item),
                                        label: {
                                            VStack(alignment:.center){
                                                Text("\(item.id)")
                                                Spacer()
                                                HStack{
                                                    Spacer()
                                                    Button {
                                                        OutfitModel.setFavourite(Outfit: item)
                                                    } label: {
                                                        if (item.Favourite == false) {
                                                            Image(systemName: "heart")}
                                                        else {Image(systemName: "heart.fill")}
                                                    }
                                                }
                                            }
                                        }
                                        
                                    )   .padding()
                                        .frame(width: 160, height: 200, alignment: .leading)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    
                                }
                            }
                        }
                        
                    }
                    
                        
                    
                    
                    }.padding()
                }
                
                
                
                
            }.navigationBarTitle("Favourite")
                .onAppear{
                    model.getFavourite()
                    OutfitModel.getFavourite()
                }
            
        } .navigationViewStyle(.stack)
        
    }
    
    
}


