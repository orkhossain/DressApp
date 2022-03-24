//
//  ClothesView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 23/11/2021.
//


import SwiftUI
import Firebase



struct OutfitsView: View {
    
    @ObservedObject var model = OutfitViewModel()
    @ObservedObject var ClothModel = ClothviewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var Item = Clothing(id: "", Object: "", Description: "", Item: "", Colour: "", Event: "", Weather: "", Gender: "", Season: "", Favourite: false, Image: "")
    
    
    
    var body: some View {
        
        ScrollView {
            if (model.list.count == 0){
                Text("You haven't created any outfit yet").font(.title).padding()
            } else {
            
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(model.list, id: \.id) { item in
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
                                            model.setFavourite(Outfit: item)
                                        } label: {
                                            if (item.Favourite == false) {
                                                Image(systemName: "heart")}
                                            else {Image(systemName: "heart.fill")}
                                        }
                                    }
                                }
                            }
                            
                        )
                            .padding()
                            .frame(width: 160, height: 200, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                    }
                }
            }.padding().navigationBarTitle("All Outfits")
            
        }
        }.onAppear{model.getOutfits()}
    }
    

    
}



