//
//  CardView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 13/02/2022.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var model = ClothviewModel()
    @State var item: Clothing
    
    var body: some View {
        VStack{
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
                    }.buttonStyle(BorderlessButtonStyle())
                }
                
            ).padding()
                .frame(width: 160, height: 200, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
        }
}
}


struct OutfitCardView: View {
    
    @ObservedObject var model = ClothviewModel()
    @State var item: String
    
    var body: some View {
        VStack{
            Text(item).padding()
                .frame(width: 160, height: 200, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
        }
}
}
