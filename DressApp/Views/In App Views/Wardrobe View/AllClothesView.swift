//
//  ClothesView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 23/11/2021.
//


import SwiftUI
import Firebase



struct ClothesView: View {
    
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
                                    Text("Colour: \(item.Colour)")}
                                    }
                                    
                                ).padding()
                                    .frame(width: 160, height: 200, alignment: .leading)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.black, lineWidth: 2)
                                        )
                                HStack{
                                Text("\(item.Item)")
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
                    }.navigationBarTitle("", displayMode: .inline)
                    
                }.onAppear{model.getClothing()}
            }

}



