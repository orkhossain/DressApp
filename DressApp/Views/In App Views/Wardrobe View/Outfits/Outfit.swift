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
    
    var user = "\(String(describing:Auth.auth().currentUser!.email))"

    @ObservedObject var OutfitModel = OutfitViewModel()
    @ObservedObject var ClothModel = ClothviewModel()
    
    @State var Outfit: Outfit
    
    @State private var showingSheet = false
    @State private var showingDelete = false
    
    @State private var Event:String = ""
    @State  private var Gender:String = ""
    @State  private var Weather:String = ""
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View {
        VStack{
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(Outfit.Clothing.sorted(by: > ), id: \.key) { key, value in
                        ForEach(ClothModel.list.filter{$0.id.contains(key)}){ clothing in

                            ZStack{
                                CardView(item: clothing)
                            }.padding()
                        }
                    }
                }
                
            }
            
            Form {
                HStack{
                    Text("Items in your outfir")
                    Spacer()
                    Text("\(Outfit.Clothing.count)")
                }
                
                HStack{
                    Text("Favourite")
                    Spacer()
                    Button {
                        OutfitModel.setFavourite(Outfit: Outfit)
                    } label: {
                        if (Outfit.Favourite == true) {
                            Image(systemName: "heart.fill")}
                        else {
                            Image(systemName: "heart")}
                    }
                    
                }.buttonStyle(BorderlessButtonStyle()).foregroundColor(.red).font(.title2)
                
                Section{
                    Text("Gender: \(Outfit.Gender)")
                    Text("Event: \(Outfit.Event)")
                    Text("Season: \(Outfit.Season)")
                }
               
                
            }
            
        }.navigationBarTitle(Text("Your Outfit"), displayMode: .large)
            .onAppear{
                ClothModel.getClothing()
                OutfitModel.getOutfits()
            }
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    
                    
                    
                    Button {
                        showingSheet.toggle()
                        
                    } label: {
                        HStack{
                            Text("Edit")
                            
                        }
                        
                    }.sheet(isPresented: $showingSheet) {
                        EditOutfit(Clothtmodel: ClothModel, Outfit: Outfit, ClothList: Outfit.Clothing, Gender: Outfit.Gender, Event: Outfit.Event, Season: Outfit.Season, Favuorite: Outfit.Favourite)
                    }
                    
                    
                    Button {
                        showingDelete = true
                    } label: {
                        HStack{
                            Image(systemName: "trash.fill").foregroundColor(.red)
                        }
                    }
                    .actionSheet(isPresented: $showingDelete) {
                        let delete = ActionSheet.Button.destructive(Text("Delete")) {
                            OutfitModel.deleteData(OutfitToDelete: Outfit)
                            self.mode.wrappedValue.dismiss()
                            
                        }
                        return  ActionSheet(
                            title: Text("Are you sure you delete this item?"),
                            buttons: [delete,.cancel()]
                        )
                    
                    }
                    

                    
                    
                }
            }
        
    }
    
    

    
    
    
    
    
    
}


