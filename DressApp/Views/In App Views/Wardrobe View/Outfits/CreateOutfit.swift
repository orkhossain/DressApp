//
//  CreateOutfit.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import SwiftUI

struct CreateOutfit: View {
    
    @ObservedObject var Clothmodel = ClothviewModel()
    @ObservedObject var Outfitmodel = OutfitViewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    var symbols = Wardrobe().symbols

    var body: some View {
        
        
        ScrollView {
            HStack{
                Text("Filter by:")
            ScrollView(.horizontal, showsIndicators: false) {
                Spacer()
                HStack(alignment:.top) {
                    ForEach(symbols, id: \.self) { clothing in
                        Text("\(clothing)")
                            .foregroundColor(.gray)
                            .frame(height: 35).padding(.leading, 5).padding(.trailing, 5)
                        
                    }.overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    ).padding(.leading,1)
                }
            }.frame(height: 40)
                
            }
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(Clothmodel.list, id: \.id) { item in
                    ZStack{
                        VStack{
                        Spacer()
                        Spacer()
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
                                            Clothmodel.setFavourite(item: item)
                                        } label: {
                                            if (item.Favourite == false) {
                                                Image(systemName: "heart")}
                                            else {Image(systemName: "heart.fill")}
                                        }
                                    }
                                }
                            }
                            
                        ).padding()
                            .frame(width: 160, height: 200, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                    }
                        
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "plus.circle.fill").font(.system(size: 35)).background(Color.white).position(x: 170, y: 20)
                        }

                    }.padding(.top,10)
                }
                
            }.navigationBarTitle("Create Outfit").onAppear{Clothmodel.getClothing()}}.padding()
        
        
        
    }
}

