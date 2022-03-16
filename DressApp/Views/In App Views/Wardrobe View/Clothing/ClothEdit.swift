//
//  EditView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 20/11/2021.
//

import SwiftUI
import Firebase

struct ClothEdit: View {
    
    var db = Firestore.firestore()
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSheet = false
    
    
    var user = "\(String(describing:Auth.auth().currentUser!.email))"

    @ObservedObject private var model = ClothviewModel()
    
    @State var Clothing:Clothing
    @State var Id:String = ""
    @State var Description:String = ""
    @State var Item:String  = ""
    @State var Colour:String  = ""
    @State var Event:String  = ""
    @State var Weather:String  = ""
    @State var Gender:String  = ""
    @State var Season:String  = ""
    
    
    var symbols = Wardrobe().symbols
    var top = Wardrobe().Top
    var bottom = Wardrobe().Bottom
    var outerlayer = Wardrobe().Outerlayer
    var shoes = Wardrobe().Shoes
    var accessories = Wardrobe().Accessories
    var colours = Wardrobe().colours
    
    var body: some View {
        
        NavigationView{
            
            Form {
                Section(header: Text("Short paragraph about the item")){
                    TextField("Description", text: $Description)
                        .frame(maxHeight: 40)
                }
                
                Section(header: Text("INFORMATION")){
                    
                    Picker("Item",selection: $Item) {
                        let allItems = top + bottom + shoes + outerlayer + accessories
                        ForEach(allItems, id: \.self) { clothing in
                            Group
                            {
                                Text("\(clothing)").tag("\(clothing)")
                                
                            }
                        }
                    }
                    
                    Picker("Gender",selection: $Gender){
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Unisex").tag("Unisex")
                    }
                    
                    Picker("Color",selection: $Colour) {
                        ForEach(colours, id: \.self) { colour in
                            Group{
                                Text("\(colour)").tag("\(colour)")
                            }
                        }
                    }
                    
                    Picker("Event",selection: $Event) {
                        Text("Casual").tag("Casual")
                        Text("Formal").tag("Formal")
                        Text("Party").tag("Party")
                        Text("Date").tag("Date")
                    }
                    
                    Picker("Weather",selection: $Weather) {
                        Text("Sunny").tag("Sunny")
                        Text("Cloudy").tag("Cloudy")
                        Text("Snow").tag("Snow")
                        Text("Rainy").tag("Rainy")
                    }
                    
                    Picker("Season",selection: $Season) {
                        Text("Spring").tag("Spring")
                        Text("Summer").tag("Summer")
                        Text("Autumn").tag("Autumn")
                        Text("Winter").tag("Winter")
                    }
                    
                    
                }
                
                Button {
                   editCLothing(clothingToEdit: Clothing)
                    model.getClothing()
                    presentationMode.wrappedValue.dismiss()
                }
                label: {
                    HStack{
                        Text("Save changes").foregroundColor(.red)
                    }
                }

                
            }.toolbar{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    
                    Text("Cancel")
                    
                }
            }.navigationBarTitle("Edit")
            
        }
    }
    

    func editCLothing(clothingToEdit: Clothing){
        db.collection(user).document(clothingToEdit.id).setData(["Description":self.Description, "Item":self.Item,"Colour": self.Colour, "Weather": self.Weather,"Event": self.Event, "Gender": self.Gender,"Season": self.Season],merge: true) { error in
            if error == nil {
                model.getClothing()
            }
        }
    }

}


