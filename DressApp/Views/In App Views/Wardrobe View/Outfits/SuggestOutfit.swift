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
    
    @State var weather: String
    @State var maxTemp: String
    @State var minTemp: String
    @State var fetched : Bool = false
    
    @State private var Event:String = ""
    @State  private var Gender:String = ""
    @State  private var Weather:String = ""

    
    @State private var genreatedOutfit = [Outfit]()
    
    var body: some View {
        Form {
            
            Section(header: Text("INFORMATION")){
                
                
                Picker("Weather",selection: $Weather) {
                    Text("Current Weather").tag(weather)
                    Text("Sunny").tag("Sunny")
                    Text("Cloudy").tag("Cloudy")
                    Text("Rainy").tag("Rainy")
                    Text("Snow").tag("Snow")
                }
                
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
                genreatedOutfit = OutfitModel
                    .generateOutfit(Weather: self.Weather, Gender: self.Gender, Event: self.Event, Clothings: Clothings, Outifits: Outfits)
                fetched = true
                self.Event = ""
                self.Gender = ""
                self.Weather = ""
                
            } label: {
                Text("Suggest me")
            }
            
            
            Button {
                genreatedOutfit = OutfitModel
                    .generateOutfit(Weather: "", Gender: "", Event: "", Clothings: Clothings, Outifits: Outfits)
                fetched = true
                self.Event = ""
                self.Gender = ""
                self.Weather = ""
                
            } label: {
                Text("Create Random")
            }
        
        if fetched == true {
            
        if( genreatedOutfit.isEmpty){
            Section{
                Text("There is no outfit that matches your parametres chosen \n Please change or generate a random outfit").foregroundColor(.red).bold()
        }
        } else {
            Section{
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment:.top) {
                    
                    ForEach(genreatedOutfit, id: \.id) { outfit in
                        NavigationLink(
                            destination: GeneratedOutfits(ClothList: Clothings, Outfit: outfit),
                            label: {
                                VStack(alignment:.center){
                                    let images = Array(Array(outfit.Clothing.values).prefix(4))
                                    Folder(outfitImages: images)
                                    
                                }
                            }
                            
                        ).frame(width: 120, height: 150)
                            .cornerRadius(15).padding(.leading, 15)
                        
                    }
                }

                }.frame(height: 160)
                
            }
        }
        }}
            else {}
        
        
        
    }
        
        
        
        .onAppear{
            OutfitModel.getOutfits()
        }
        .navigationBarTitle("Suggest me an outfit")
    }
    
}

