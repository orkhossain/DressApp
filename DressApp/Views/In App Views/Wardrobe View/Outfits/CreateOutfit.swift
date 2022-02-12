//
//  CreateOutfit.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import SwiftUI

struct CreateOutfit: View {
    
    @ObservedObject var Clothmodel = ClothviewModel()
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    var symbols = Wardrobe().symbols
    @State var isfetched : Bool = false
    @State var ClothList: [Clothing]

    @State var tempList : [String] = []

    
    var body: some View {
                
       VStack{ ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment:.top) {
                ForEach(tempList, id: \.self) { clothing in
                    ZStack{
                        HStack{Text("\(clothing)")
                                .foregroundColor(.gray)
                                .frame(width: 80, height: 80).padding(.leading, 5).padding(.trailing, 5).overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                ).padding(.leading,1)}
                        
                        Button {
                            if let index = tempList.firstIndex(of: "\(clothing)") {
                                tempList.remove(at: index)
                            }
                            
                        } label: {
                            Image(systemName: "minus.circle.fill").font(.system(size: 20)).background(Color.white).position(x: 92, y: 2)
                        }
                    }.padding(10)
                }
            }.padding(.top,10).padding(.bottom, 7)}.onAppear{
                Clothmodel.getClothing()
                ClothList = Clothmodel.list
                isfetched = true
               }.frame(width: UIScreen.main.bounds.width - 25, height: 100).overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 5)).padding()
        
        
        VStack{
            HStack{
                Button {
                    ClothList = Clothmodel.list
                } label: {
                    Text("All") .foregroundColor(.gray)
                        .frame(height: 35).padding(.leading, 5).padding(.trailing, 5)
                }.padding(5).overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2))
                
                
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment:.top) {
                        ForEach(symbols, id: \.self) { clothing in
                            Button {
                                ClothList = Clothmodel.list.filter{ $0.Item.contains("\(clothing)")}
                            } label: {
                                Text("\(clothing)")
                                    .foregroundColor(.gray)
                                    .frame(height: 35).padding(.leading, 5).padding(.trailing, 5)

                            }
                        }.padding(5).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 2))
                        
                    }.padding(.leading,1)
                }
            }.padding(5)
            
            
        }.frame(width: UIScreen.main.bounds.width - 25)
        

        
           if(isfetched == true){ ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach(ClothList, id: \.id) { item in
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
                                            Text("Id: \(item.id)")
                                            
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
                                if tempList.contains("\(item.id)")
                                {} else {tempList.append("\(item.id)")
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }.font(.system(size: 35)).background(Color.white).position(x: 170, y: 20).buttonStyle(BorderlessButtonStyle())
                            
                        }.padding(.top,10)
                    }
                    
                }
            }.padding()}
            
       }.navigationBarTitle("Create Outfit")
            .navigationBarItems(trailing:
        NavigationLink(destination: AddOutfit(ClothList: tempList), label: {
           HStack{
               Text("Next")
           }
            }).disabled(tempList.count < 2))
            
}
    }
    



