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
    @Environment(\.presentationMode) var presentationMode
    @State var ClothList: [String]
    @State var Gender:String = ""
    @State var Event:String = ""
    @State var Season:String = ""
    @State var Favuorite:Bool = false
    
    
    var body: some View {
       
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment:.top) {
                ForEach(ClothList, id: \.self) { clothing in
                   
                    
                    ZStack{
                        

                        OutfitCardView(item: clothing)

                        Button {
                            if let index = ClothList.firstIndex(of: "\(clothing)") {
                                ClothList.remove(at: index)
                            }
                            
                        } label: {
                            Image(systemName: "minus.circle.fill").background(Color.white).font(.system(size: 25))
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
                Outfitmodel.createOutfit(Clothing: self.ClothList, Event: self.Event, Gender: self.Gender, Favourite: false, Season: self.Season)
                ClothList = []
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

