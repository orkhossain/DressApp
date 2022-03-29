//
//  ClothesView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 23/11/2021.
//


import SwiftUI
import Firebase



struct OutfitsView: View {
    
    @ObservedObject var OutfitModel = OutfitViewModel()
    @ObservedObject var ClothModel = ClothviewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var Item = Clothing(id: "", Object: "", Description: "", Item: "", Colour: "", Event: "", Weather: "", Gender: "", Season: "", Favourite: false, Image: "")
    
    
    
    var body: some View {
        
        ScrollView {
            if (OutfitModel.list.count == 0){
                Text("You haven't created any outfit yet").font(.title).padding()
            } else {
            
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(OutfitModel.list, id: \.id) { item in
                        
                        let clothingImages = Array((item.Clothing.values).prefix(4))
                       
                        NavigationLink(
                            destination: OutfitView(Outfit: item),
                            label: {
                                VStack(alignment:.center){
                            Folder(outfitImages: clothingImages)
                                }
                            }

                        ).frame(width: 140, height: 180, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                }
                
            }.navigationBarTitle("All Outfits")}
        }.onAppear{OutfitModel.getOutfits()
            
        }
    }
    

    
}



