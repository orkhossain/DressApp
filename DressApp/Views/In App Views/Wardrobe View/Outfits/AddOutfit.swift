//
//  AddOutfit.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 12/02/2022.
//
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase

struct AddOutfit: View {
    
    @ObservedObject var Outfitmodel = OutfitViewModel()
    
    @State var ClothList: [String]
    @State var Gender:String = ""
    @State var Event:String = ""
    @State var Season:String = ""
    @State var Favuorite:Bool = false

    
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
                  
                Picker("Season",selection: $Season) {
                    Text("Spring").tag("Spring")
                    Text("Summer").tag("Summer")
                    Text("Autumn").tag("Autumn")
                    Text("Winter").tag("Winter")
                }

            }

            Button(action: {
                Outfitmodel.createOutfit(Clothing: self.ClothList, Event: self.Event, Gender: self.Gender, Favourite: false, Season: self.Season)
                  Event = ""
                  Gender = ""
                  Season = ""
                  Favuorite = false
            }, label: {
                Text("Add Item")
            })
                .disabled(Event.isEmpty || Gender.isEmpty || Season.isEmpty)
        }
    }
}

