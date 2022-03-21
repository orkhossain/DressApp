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
    
    @State public var symbols = ["Top","Bottom","Shoes","Outerlayer","Accesories"]
    
    @State public var Top = ["T-shirt","Shirt", "Sweater","Turtleneck","Suit","Hawaiian-shirt","Vest","Polo","Blazer","Waistcoat","Dress","Long-Dress","Hoodie"]
    @State public var Bottom = ["Trousers","Jeans","Shorts","Cargo","Chino","Suit-Trouser"]
    @State public var Outerlayer = ["Leather Jacket","Parka","Puffer","Trenchcoat","Jacket","Denim Jacket","Overshirt","Cardigan"]
    @State public var Shoes = [ "Sneakers","Chelsea Boots","Worker-Boots","Formal-Shoes"]
    @State public var Accessories = ["Belt","Tie","Cap","Scarf","Bow tie","Handbag"]

    
    @State public var colours = ["Black","White","Blue","Beige","Burgundy","Green","Brown","Orange","Purple","Gray"]
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ObservedObject var model = ClothviewModel()
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
                            
                            HStack(alignment:.top) {
                                ForEach(OutfitModel.favouriteList, id: \.id) { outfit in
                                    NavigationLink(
                                        destination: OutfitView(Outfit: outfit),
                                        label: {
                                            VStack(alignment:.center){
                                                Text("\(outfit.id)")
                                                
                                            }
                                        }
                                        
                                    )
                                        .foregroundColor(.white).font(.title2)
                                        .frame(width: 120, height: 150)
                                        .background(Color.red)
                                        .cornerRadius(15).padding(.leading, 15)
                                    
                                }
                                
                                
                                NavigationLink {
                                    CreateOutfit(ClothList: model.list)
                                } label: {
                                    Image(systemName: "plus.circle").padding().font(.system(size: 45)).foregroundColor(.red)
                                        .frame(width: 120, height: 150, alignment: .center)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.red, lineWidth: 4)
                                        ).padding(.leading, 10).padding(.trailing, 10)
                                }.disabled(model.list.count < 2)
                                
                                
                                
                                
                            }.frame(height: 160)
//                                .padding(.bottom, 15)
                        }.onAppear{
                            OutfitModel.getFavourite()
                            model.getClothing()
                        }
                        
                    }.padding()
                }.navigationBarTitle("", displayMode: .inline).navigationBarHidden(true)
                
                
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
                        
                    
                }
                
            }.navigationBarTitle("", displayMode: .inline).navigationBarHidden(true)
            
        }.navigationViewStyle(.stack)
        
        
    }
}
