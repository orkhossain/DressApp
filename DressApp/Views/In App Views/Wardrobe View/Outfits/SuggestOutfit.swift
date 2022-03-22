//
//  SuggestOutfit.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import SwiftUI
import Firebase

struct SuggestOutfit: View {
    
    @ObservedObject private var OutfitModel = OutfitViewModel()
    @State var Clothings:  [Clothing]
    @State var Outfits: [Outfit]
    @State var Weather: String
    @State var maxTemp: String
    @State var minTemp: String
    @State private var Event:String = ""
    @State  private var Gender:String = ""
    @State private var genreatedOutfit = []
    
    var body: some View {
        Form {
            
            Section(header: Text("INFORMATION")){
                
                Picker("Gender",selection: $Gender){
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
                
                Picker("Event",selection: $Event) {
                    Text("Casual").tag("Casual")
                    Text("Formal").tag("Formal")
                    Text("Party").tag("Party")
                    Text("Date").tag("Date")
                }
                
                
            }
            
            
            Button {
                OutfitModel
                    .generateOutfit(Weather: Weather, minTemp: minTemp,
                                    maxTemp: maxTemp, gender: self.Gender, Event: self.Event, Clothings: Clothings, Outifits: Outfits)
                self.Event = ""
                self.Gender = ""
            } label: {
                Text("print")
            }.disabled(self.Event == "" && self.Gender == "")
            
        }
        
        .onAppear{
            OutfitModel.getOutfits()
        }
        .navigationBarTitle("Suggest me an outfit")
    }
    
    
    
    //
    //    func generateOutfit(){
    //        ForEach(ClothModel.list, id: \.id){ item in
    //            genreatedOutfit.append(item)
    //
    //        }
    //    }
}

