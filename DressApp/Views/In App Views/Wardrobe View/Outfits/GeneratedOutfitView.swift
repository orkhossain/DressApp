//
//  OutfitView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 26/03/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct GeneratedOutfits: View {
    
    var user = "\(String(describing:Auth.auth().currentUser!.email))"
    
    @ObservedObject var Outfitmodel = OutfitViewModel()
    @State var ClothList : [Clothing]
    
    @State var Outfit: Outfit
    @State private var Event:String = ""
    @State  private var Gender:String = ""
    @State  private var Weather:String = ""
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View {
        VStack{
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(Outfit.Clothing.sorted(by: > ), id: \.key) { key, value in
                        ForEach(ClothList.filter{$0.id.contains(key)}){ clothing in
                            
                            ZStack{
                                CardView(item: clothing)
                            }.padding()
                        }
                    }
                }
                
            }
            
            Form {
                Section{
                    Text("Season: \(Outfit.Season)")
                    
                    if Outfit.Gender == "" {
                        Picker("Gender",selection: $Gender){
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }}
                    else{
                        Text("Gender: \(Outfit.Gender)")
                    }
                    
                    if Outfit.Event == "" {
                        Picker("Event",selection: $Event) {
                            Text("Casual").tag("Casual")
                            Text("Formal").tag("Formal")
                            Text("Party").tag("Party")
                            Text("Date").tag("Date")
                        }}else{
                            Text("Gender: \(Outfit.Event)")
                        }
                }
                
                Button(action: {
                    Outfitmodel.createOutfit(Clothing: Outfit.Clothing, Event: Outfit.Event, Gender: Outfit.Gender, Favourite: false, Season: Outfit.Season)
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("Add Outfit")
                }).disabled(Outfit.Event.isEmpty || Outfit.Gender.isEmpty || Outfit.Season.isEmpty)
                
                
            }
            
        }.navigationBarTitle(Text("Your Outfit"), displayMode: .large)
            .onAppear{
                Outfitmodel.getOutfits()
            }
        
    }
      
}


