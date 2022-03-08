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
    
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                HStack{
                    Button {
                        currentFavouriteList = 0
                    } label: {
                        Text("Clothings")
                    }
                    
                    Button {
                        currentFavouriteList = 1
                    } label: {
                        Text("Outfits")
                    }
                }
                
                VStack{
     
                    favList(currentFavouriteList: self.$currentFavouriteList)
                    
                }.navigationBarTitle("Favourites",displayMode: .automatic)
                
                
            }
            
        }
        
        
        
    }
}


struct favList: View {
    @ObservedObject private var model = ClothviewModel()
    @ObservedObject private var OutfitModel = OutfitViewModel()
    
    @Binding var currentFavouriteList: Int
    
    var body: some View {
        VStack{
            if currentFavouriteList != 1{
                FavClothView(list: model.favouriteList)
            }
            else{
                FavOutfitView(list: OutfitModel.favouriteList)
            }
        }.onAppear{
            model.getFavourite()
            OutfitModel.getFavourite()
            
        }
    }
}



struct FavClothView: View {
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @State var list: [Clothing]
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                
                ForEach(list){ item in
                    
                    CardView(item: item)
                }
                
            }
            
        }.padding()
        
    }
}

struct FavOutfitView: View {
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @State var list: [Outfit]
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                
                ForEach(list){ item in
                    OutfitCardView(item: item.id)
                }
                
            }
            
        }.padding()
        
    }
}

