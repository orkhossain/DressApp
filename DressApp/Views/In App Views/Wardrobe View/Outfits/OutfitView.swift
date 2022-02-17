//
//  OutfitView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct OutfitView: View {
    
    
    @ObservedObject var model = OutfitViewModel()
    @ObservedObject var ClothModel = ClothviewModel()
    @State var Outfit: Outfit
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @State var Item = Clothing(id: "", Object: "", Description: "", Item: "", Colour: "", Event: "", Weather: "", Gender: "", Season: "", Favourite: false)
    
    
    var body: some View {
        VStack{
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(Outfit.Clothing, id: \.self) { item in
                        ForEach(ClothModel.list.filter{$0.id.contains(item)}){ clothing in
                            ZStack{
                                CardView(item: clothing)
                            }.padding()
                        }
                    }
                }
                
            }
            
            Form {
                Section{
                    Text("Gender: \(Outfit.Gender)")
                    Text("Event: \(Outfit.Event)")
                    Text("Season: \(Outfit.Season)")
                }
            }
            
        }.navigationBarTitle(Text("Your Outfit"), displayMode: .large).onAppear{ClothModel.getClothing()}
        
    }
    
    
    
}


