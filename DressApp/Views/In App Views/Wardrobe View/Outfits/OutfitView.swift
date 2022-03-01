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
    
    @State private var showingSheet = false
    @State private var showingDelete = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
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
               
                Button {
                    showingDelete = true
                } label: {
                    HStack{
                        Image(systemName: "trash.fill").foregroundColor(.red)
                        Text("Delete").foregroundColor(.red)
                    }
                }
                .actionSheet(isPresented: $showingDelete) {
                    let delete = ActionSheet.Button.destructive(Text("Delete")) {
                        model.deleteData(OutfitToDelete: Outfit)
                        self.mode.wrappedValue.dismiss()
                        
                    }
                    return  ActionSheet(
                        title: Text("Are you sure you delete this item?"),
                        buttons: [delete,.cancel()]
                    )
                
                }
                
                Button {
                    showingSheet.toggle()
                } label: {
                    HStack{
                        Image(systemName: "square.and.pencil")
                        Text("Edit")
                        
                    }
                    
                }.sheet(isPresented: $showingSheet) {
                    EditOutfit(Outfit: Outfit, ClothList: Outfit.Clothing, Gender: Outfit.Gender, Event: Outfit.Event, Season: Outfit.Season, Favuorite: Outfit.Favourite)
                }
                
                
                
                
                
                
            }
            
        }.navigationBarTitle(Text("Your Outfit"), displayMode: .large)
            .onAppear{ClothModel.getClothing()
                model.getOutfits()
            }
        
    }
    
    
    
}


