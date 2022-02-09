//
//  ClothesView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 23/11/2021.
//


import SwiftUI
import Firebase



struct OutfitsView: View {
    
    @ObservedObject var model = ClothviewModel()
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(model.list, id: \.id) { item in
                    VStack{
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
                                            model.setFavourite(item: item)
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
                }
            }.navigationBarTitle("", displayMode: .inline).padding()
            
        }
        
        
        .onAppear{model.getClothing()}
    }
    
}



