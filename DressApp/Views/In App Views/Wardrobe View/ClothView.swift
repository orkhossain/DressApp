//
//  ClothingView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 09/11/2021.
//

import SwiftUI
import Firebase

struct ClothView: View {
    
    @ObservedObject  var model = ClothviewModel()
    @State private var showingSheet = false
    @State private var showingDelete = false
    @State  var item: Clothing
    
    //    @State private var showingDelete = false
    
    //    @State var Favuorite:Bool = false
    
    
    var body: some View {
        
        Form {            
            Section(header:Text("\(item.Item)").font(.title2).foregroundColor(.black))
            {
                Text("Description: \(item.Description)")
                Text("Gender: \(item.Gender)")
                Text("Colour: \(item.Colour)")
                Text("Event: \(item.Event)")
                Text("Weather: \(item.Weather)")
                Text("Season: \(item.Season)")
                //Bool("URL: \(item.Favourite)")
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
                let delete = ActionSheet.Button.destructive(Text("Delete")) {model.deleteData(clothingToDelete: item)}
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
                SheetView(Clothing: item, Id:item.id ,Description: item.Description, Item: item.Item, Colour: item.Colour, Event: item.Event, Weather: item.Weather, Gender: item.Gender, Season: item.Season)
            }
        }.navigationBarTitle("", displayMode: .inline).onAppear{
            if !showingSheet{
                model.getClothing()
            }
            model.getClothing()
        }
    }
    
    
}






