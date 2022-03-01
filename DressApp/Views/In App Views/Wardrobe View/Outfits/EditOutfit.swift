//
//  EditOutfit.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 16/01/2022.
//

import SwiftUI
import Firebase


struct EditOutfit: View {
    
    
    var db = Firestore.firestore()
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSheet = false
    
    
    var user = "\(String(describing:Auth.auth().currentUser!.email))"
    
    @ObservedObject private var Outfitmodel = OutfitViewModel()
    
    @State var Outfit: Outfit
    @State var ClothList: [String] = []
    @State var Gender:String = ""
    @State var Event:String = ""
    @State var Season:String = ""
    @State var Favuorite:Bool = false
    
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment:.top) {
                        ForEach(Outfit.Clothing, id: \.self) { clothing in
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
                        editOutfit(Outfit: Outfit)
                        Outfitmodel.getOutfits()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save changes")
                    }).disabled(Event.isEmpty || Gender.isEmpty || Season.isEmpty).disabled(Outfit.Clothing.count < 2)
                    
                }
                
            }
        }.navigationBarTitle("Edit")
            .toolbar{
                Button(action: {
                 
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    
                    Text("Cancel")
                    
                }
            }
    }
    
    
    
    func editOutfit(Outfit: Outfit){
        db.collection(user).document(Outfit.id).setData(["Clothing":self.ClothList ,"Event": self.Event, "Gender": self.Gender,"Season": self.Season],merge: true) { error in
            if error == nil {
                
            }
        }
    }
    
}
