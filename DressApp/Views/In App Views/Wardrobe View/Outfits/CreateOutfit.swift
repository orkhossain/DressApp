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
    
    @State var ClothList: [Clothing]
    @State var List: [Clothing] = []
    @State var tempList : [String] = []
    
    @State private var showingSheet = false

    
    var body: some View {
        
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment:.top) {
                    ForEach(tempList, id: \.self) { clothing in
                       
                        ZStack{
                            OutfitCardView(item: clothing)
                            Button {
                                if let index = tempList.firstIndex(of: "\(clothing)") {
                                    tempList.remove(at: index)
                                }
                                
                            } label: {
                                Image(systemName: "minus.circle.fill").background(Color.white).font(.system(size: 25))
                            }.position(x: 158, y: 20)
   
                            
                        }.frame( height: 230 )
                        
                    }.padding(.leading, 10).padding(.trailing, 10)
                    
                }
                
            }.navigationBarTitle("Create Outfit", displayMode: .inline)
            
                
                HStack{
                    
                    
                    
                    Button {
                        List = ClothList
                    } label: {
                        Text("All") .foregroundColor(.gray)
                            .frame(height: 35).padding(.leading, 5).padding(.trailing, 5)
                    }.overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2))
                    
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(symbols, id: \.self) { clothing in
                                Button {
                                    List = ClothList.filter{ $0.Item.contains("\(clothing)")}
                                } label: {
                                    Text("\(clothing)")
                                        .foregroundColor(.gray)
                                        .frame(height: 35).padding(.leading, 5).padding(.trailing, 5)
                                }.overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 2))
                            }}}}.frame(width: UIScreen.main.bounds.width - 25, height: 30)

            
            
            

                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 10) {
                        ForEach(List, id: \.id) { item in
                            ZStack{
                                
                                CardView(item: item)
                                
                                Button {
                                    if tempList.contains("\(item.id)")
                                    {} else {tempList.append("\(item.id)")
                                    }
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                }.font(.system(size: 35)).background(Color.white).position(x: 170, y: 5).buttonStyle(BorderlessButtonStyle())
                            }
                        }.padding(.top,15)
                        
                    }
                }.padding()

            
        }
        .onAppear{List =  ClothList}
            .navigationBarItems(trailing:
                                NavigationLink(destination: AddOutfit(ClothList: tempList), label: {
                HStack{
                    Text("Next")
                }
                
                
                
            }).disabled(tempList.count < 2))
        

        
    }
}




