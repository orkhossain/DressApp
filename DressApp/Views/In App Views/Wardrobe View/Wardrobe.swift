//
//  Wardrobe.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 30/06/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct Wardrobe: View {
    
    
    var Top = ClothViewModel().Top
    var Bottom = ClothViewModel().Bottom
    var Outerlayer = ClothViewModel().Outerlayer
    var Shoes = ClothViewModel().Shoes
    var Accessories = ClothViewModel().Accessories
    var Colours = ClothViewModel().colours
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ObservedObject var ClothModel = ClothViewModel()
    @ObservedObject var OutfitModel = OutfitViewModel()
    @State var newItem : String = ""
    
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                ZStack{
                    
                    Color.gray
                        .opacity(0.1)
                        .cornerRadius(15)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 230)
                    
                    VStack{
                        
                        HStack{
                            Text("Outfits").font(.title).bold()
                            Spacer()
                            NavigationLink {
                                OutfitsView()
                            } label: {
                                Text("View All").font(.title3)
                            }
                            
                        }.padding(.leading, 10).padding(.trailing, 10)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                ForEach(OutfitModel.favouriteList, id: \.id) { outfit in
                                    NavigationLink(
                                        destination: OutfitView(Outfit: outfit),
                                        label: {
                                            VStack(alignment:.center){
                                                let images = Array(Array(outfit.Clothing.values).prefix(4))
                                                Folder(outfitImages: images)
                                                
                                            }
                                        }
                                        
                                    ).frame(width: 120, height: 160)
                                        .cornerRadius(16).overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    
                                    
                                }
                                
                                
                                NavigationLink {
                                    CreateOutfit(ClothList: ClothModel.list)
                                } label: {
                                    Image(systemName: "plus.circle").padding().font(.system(size: 45)).foregroundColor(.red)
                                        
                                }.frame(width: 120, height: 160, alignment: .center)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.red, lineWidth: 4)
                                    ).padding(.leading, 10).padding(.trailing, 10).disabled(ClothModel.list.count < 2)
                                
                                
                                
                                
                            }.frame(height: 170).padding(.leading,10)
                            
                        }.onAppear{
                            OutfitModel.getOutfits()
                            OutfitModel.getFavourite()
                            ClothModel.getClothing()
                            
                        }
                        
                    }.padding()
                }.navigationBarTitle("", displayMode: .inline).navigationBarHidden(true).navigationViewStyle(.stack)
                
                
                ZStack{
                    Color.red
                        .cornerRadius(15)
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .padding(.bottom, 10)
                    
                    VStack(alignment: .leading){
                        
                        
                        HStack(alignment: .top){
                            Text("Wardrobe").font(.title2).bold().foregroundColor(.white).padding()
                            Spacer()
                            NavigationLink {
                                ClothesView()
                            } label: {
                                Text("View All").font(.title3).foregroundColor(.white).padding()
                            }
                            
                        }.padding(.leading, 10).padding(.trailing, 10)
                        
                        
                        ScrollView {
                            let allItems = Top + Bottom + Outerlayer + Shoes + Accessories
                            LazyVGrid(columns: gridItemLayout, spacing: 25) {
                                ForEach(allItems, id: \.self) { count in
                                    NavigationLink(
                                        destination:
                                            CategoryView(category: count),
                                        label: {
                                            Text("\(count)")
                                                .bold()
                                                .foregroundColor(.black)
                                                .padding(10)
                                                .frame(width: 160, height: 50, alignment: .leading)
                                            .background(Color.white).cornerRadius(10)}
                                        
                                        
                                    )
                                }
                                
                            }
                            
                            
                            
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .padding(.bottom, 20)
                        
                    }
                    
                    
                }.navigationBarTitle("", displayMode: .inline).navigationBarHidden(true).navigationViewStyle(.stack)
                
            }.navigationBarTitle("", displayMode: .inline).navigationBarHidden(true).navigationViewStyle(.stack)
            
        }.navigationViewStyle(.stack)
        
        
    }
    
    
    
}
