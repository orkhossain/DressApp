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
    @State var item: Clothing
    @State var image: UIImage
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    
    
    var body: some View {
        
        

        Form {
            
            
            VStack(alignment: .leading){
                Text("\(item.Item)").font(.title)

                Image(uiImage: image).resizable().scaledToFill()
                    .cornerRadius(16)
            }
            
            Section()
            {
                Text("Description: \(item.Description)")
                Text("Gender: \(item.Gender)")
                Text("Colour: \(item.Colour)")
                Text("Event: \(item.Event)")
                Text("Weather: \(item.Weather)")
                Text("Season: \(item.Season)")
            }
            
//            }
        }.navigationBarTitle("", displayMode: .inline)
            .onAppear{
            if !showingSheet{
                model.getClothing()
            }
            model.getClothing()
        }
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    
                    Button {
                        showingSheet.toggle()
                    } label: {
                        HStack{
//                            Image(systemName: "square.and.pencil")
                            Text("Edit")
                            
                        }
                        
                    }.sheet(isPresented: $showingSheet) {
                        ClothEdit(Clothing: item,Id:item.id ,Description: item.Description, Item: item.Item, Colour: item.Colour, Event: item.Event, Weather: item.Weather, Gender: item.Gender, Season: item.Season, image: image)
                    }

                    
                    
                Button {
                    showingDelete = true
                } label: {
                    HStack{
                        Image(systemName: "trash.fill").foregroundColor(.red)
//                        Text("Delete").foregroundColor(.red)
                    }
                }
                .actionSheet(isPresented: $showingDelete) {
                    let delete = ActionSheet.Button.destructive(Text("Delete"))
                    {model.deleteData(clothingToDelete: item)
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






