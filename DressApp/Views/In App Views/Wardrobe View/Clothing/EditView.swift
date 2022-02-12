//
//  EditView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 20/11/2021.
//

import SwiftUI
import Firebase

struct SheetView: View {
    
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
    
    var body: some View {
        
        NavigationView{
            
            Form {
                Section(header: Text("Short paragraph about the item")){
                    TextField("Description", text: $Description)
                        .frame(maxHeight: 40)
                }
                
                Section(header: Text("INFORMATION")){
                    
                    Picker("Item" ,selection: $Item) {
                        Group
                        {
                            Text("Shirt").tag("Shirt")
                            Text("T-Shirt").tag("T-Shirt")
                            Text("Polo").tag("Polo")
                            Text("Trousers").tag("Trousers")
                            Text("Jacket").tag("Jacket")
                            Text("Jumper").tag("Jumper")
                            Text("Hoodie").tag("Hoodie")
                            Text("Coat").tag("Coat")
                            Text("Cardigan").tag("Cardigan")
                            Text("Jeans").tag("Jeans")
                        }
                    }
                    
                    Picker("Gender",selection: $Gender){
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                    
                    Picker("Colour",selection: $Colour) {
                        Group{
                            Text("Black").tag("Black")
                            Text("White").tag("White")
                            Text("Red").tag("Red")
                            Text("Gray").tag("Gray")
                            Text("Yellow").tag("Yellow")
                            Text("Green").tag("Green")
                            Text("Blue").tag("Blue")
                            Text("Orange").tag("Orange")
                            Text("Purple").tag("Purple")
                            Text("Pink").tag("Pink")
                        }
                        Group{
                            Text("Rainbow").tag("Rainbow")
                            
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
                        Text("Save").foregroundColor(.red)
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


