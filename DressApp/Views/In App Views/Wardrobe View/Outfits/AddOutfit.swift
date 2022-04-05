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
    
    @ObservedObject var OutfitModel = OutfitViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var ClothList: [String:String]
    @State var Gender:String = ""
    @State var Event:String = ""
    @State var Season:String = ""
    @State var Favuorite:Bool = false
    
    
    var body: some View {
       
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment:.top) {
                ForEach(ClothList.sorted(by: >), id: \.key) { key,value  in
                   
                    
                    ZStack{
                        OutfitCardView(imagePath: ClothList[key]!)
                        Button {
                            if let index = ClothList.index(forKey: key) {
                                ClothList.remove(at: index)
                            }
                            
                        } label: {
                            Image(systemName: "minus.circle.fill").background(Color.white) .clipShape(Circle()).font(.system(size: 25))
                        }.position(x: 158, y: 20)

                        
                    }.frame( height: 230 )
                    
                }.padding(.leading, 10).padding(.trailing, 10)
                
            }
            
        }
        
        
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
                OutfitModel.createOutfit(Clothing: self.ClothList, Event: self.Event, Gender: self.Gender, Favourite: false, Season: self.Season)
                ClothList = [:]
                Event = ""
                Gender = ""
                Season = ""
                Favuorite = false
            }, label: {
                Text("Add Outfit")
            })
                .disabled(Event.isEmpty || Gender.isEmpty || Season.isEmpty)
            
        }.navigationBarTitle(Text("Add to your wardrobe"))
    }
}

