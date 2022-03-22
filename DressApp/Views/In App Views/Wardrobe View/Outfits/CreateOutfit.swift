//
//  CreateOutfit.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import SwiftUI

struct CreateOutfit: View {
    
    
    @State var ClothList: [Clothing]
    @State private var List: [Clothing] = []
    @State var tempList : [String] = []
    

    
    var body: some View {
        
        VStack{
            
            
            ListView(tempList: $tempList)
            
            
            EditList(tempList: $tempList, List: List, ClothList: ClothList)

            
        }
      
            .navigationBarItems(trailing:
                                NavigationLink(destination: AddOutfit(ClothList: tempList), label: {
                HStack{
                    Text("Next")
                }
                
                
                
            }).disabled(tempList.count < 2))
        

        
    }
}


struct ListView: View{
    
    @Binding var tempList : [String]
    
    var body: some View{
        
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
            
        }
        .navigationBarTitle("", displayMode: .inline)
        
    }
}


struct EditList: View{
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var symbols = Wardrobe().symbols
    var top = Wardrobe().Top
    var bottom = Wardrobe().Bottom
    var outerlayer = Wardrobe().Outerlayer
    var shoes = Wardrobe().Shoes
    var accessories = Wardrobe().Accessories
    
    @Binding var tempList : [String]
    @State var List: [Clothing]
    @State var ClothList: [Clothing]


    
    var body: some View{
     VStack{
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
                    let allItems = top + bottom + outerlayer + shoes + accessories
                    ForEach(allItems, id: \.self) { clothing in
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
        }.padding()  .onAppear{List =  ClothList}}
     .navigationBarTitle("", displayMode: .inline)
//     .navigationBarHidden(true)
        
    }
}
