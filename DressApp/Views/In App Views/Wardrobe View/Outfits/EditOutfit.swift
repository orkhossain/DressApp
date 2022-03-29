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
    var user = "\(String(describing:Auth.auth().currentUser!.email))"
    
    @ObservedObject private var Outfitmodel = OutfitViewModel()
    
    @State var Clothtmodel : ClothviewModel
    @State var Outfit: Outfit
    
    @State var ClothList: [String:String]
    @State var Gender:String = ""
    @State var Event:String = ""
    @State var Season:String = ""
    @State var Favuorite:Bool = false
    @State private var showingSheet = false
    @State private var bottomSheetShown = false
  
    
    var body: some View {
            
            
        NavigationView{
            
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment:.top) {
                        ForEach(Outfit.Clothing.sorted(by: >), id: \.key) { key, value in
                            
                            ZStack{

                                OutfitCardView(item: key, imagePath: value)
                                
                                Button {
                                    
                                    if let index = Outfit.Clothing.index(forKey: key) {
                                        Outfit.Clothing.remove(at: index)
                                    }

                                } label: {
                                    Image(systemName: "minus.circle.fill").background(Color.white) .clipShape(Circle()).font(.system(size: 25))
                                }.position(x: 158, y: 20)
       
                                
                            }.frame( height: 230 )
                            
                            
                            
                        }.padding(.leading, 10).padding(.trailing, 10)
                            
                        NavigationLink {
                            editView(Outfit: $Outfit, Clothtmodel: $Clothtmodel)
                        } label: {
                            VStack{
                                Image(systemName: "plus.circle").padding().font(.system(size: 60)).foregroundColor(.gray)
                                    .frame(width: 160, height: 200, alignment: .center)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.gray, lineWidth: 1)
                                    ).padding(.leading, 10).padding(.trailing, 10).padding(.top, 15)
                                
                            }
                        }
                        
                    }
                }
                
                
                Form {
                    
                    Section(header: Text("INFORMATION")){
                        
                        Picker("Gender",selection: $Gender){
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                            Text("Other").tag("Other")
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
                        print(self.Outfit.Clothing)
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save changes")
                    }).disabled(Event.isEmpty || Gender.isEmpty || Season.isEmpty).disabled(Outfit.Clothing.count < 2)
                    
                }
                
            }
            .navigationBarTitle("", displayMode: .inline).navigationBarHidden(true)
            
        }
        
    
    }
    
    func editOutfit(Outfit: Outfit){
        db.collection(user).document(Outfit.id).setData(["Outfit": []],merge: true)
        db.collection(user).document(Outfit.id).setData(["Outfit": self.Outfit.Clothing ,"Event": self.Event, "Gender": self.Gender,"Season": self.Season],merge: true) { error in
            if error == nil {
                print("Updated")
                print(Outfit.Clothing)
            }
            else{
                print("Not Updated")
            }
        }
    }

    

    
}




struct editView: View {
    
    @Binding var Outfit: Outfit
    @Binding var Clothtmodel: ClothviewModel
    
    var body: some View {
        VStack{
            
            ListView(tempList: $Outfit.Clothing)
            EditList(tempList: $Outfit.Clothing, List: [], ClothList: Clothtmodel.list)
            
            
        }
    }
}

