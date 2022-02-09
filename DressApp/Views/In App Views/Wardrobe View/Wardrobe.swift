//
//  Wardrobe.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 30/06/2021.
//

import SwiftUI
import Firebase


struct Wardrobe: View {
    // let db = Firestore.firestore()
    
     public var symbols = [
        "Shirt", "T-Shirt", "Polo", "Trouser", "Jacket", "Jumper", "Hoodie", "Coat", "Cardigan", "Jeans"]
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ObservedObject  var model = ClothviewModel()
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                ZStack{
                    
                    Color.gray
                        .opacity(0.1)
                        .cornerRadius(15)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 230)
                    
                    VStack(alignment: .leading){
                        
                        HStack{
                        Text("Outfits").font(.title2).bold()
                            Spacer()
                            NavigationLink {
                                OutfitsView()
                            } label: {
                                Text("View All").font(.title3)
                            }.padding(.trailing, 10)
                            
                        }.padding()
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment:.top) {
                                ForEach(0..<10) {
                                    Text("Your favourite Outfits \n \($0)")
                                        .foregroundColor(.white).font(.title2)
                                        .frame(width: 120, height: 150)
                                        .background(Color.red)
                                        .cornerRadius(15).padding(.leading, 15)
                                    
                                }
                            }.frame(height: 160).padding(.bottom, 15)
                        }
                    }.navigationBarTitle("Wardrobe")
                }
                
                
                ZStack{
                    GeometryReader {_ in
                        Color.red
                        
                        VStack(alignment: .leading){
                            
                            
                            HStack(alignment: .top){
                                Text("Wardrobe").font(.title2).bold().foregroundColor(.white)
                                Spacer()
                                NavigationLink {
                                    ClothesView()
                                } label: {
                                    Text("View All").font(.title3).foregroundColor(.white)
                                }
                                
                            }.padding()
                            
                            
                            ScrollView {
                                LazyVGrid(columns: gridItemLayout, spacing: 25) {
                                    ForEach(symbols, id: \.self) { count in
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
                            }   .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .padding(.bottom, 20)
                                .navigationBarTitle("").navigationBarHidden(true)
                            
                        }
                        
                    }
                } .cornerRadius(15)
                    .padding(10)
                
            }
            
        }
        
        
    }
}
