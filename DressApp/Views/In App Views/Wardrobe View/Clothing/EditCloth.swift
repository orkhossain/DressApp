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
    @State var image: UIImage
    
    @State private var showSheet = false
    
    
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
                
                
                VStack(alignment: .center) {
                    
                    
                    
                    
                    Button(action: {
                        self.showSheet = true
                    }) {
                        
                        HStack(alignment: .center){
                            
                            if image.size.width != 0  {
                                
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                            }
                            
                            
                            else{
                                
                                HStack {
                                    
                                    Image(systemName: "plus.circle")
                                        .font(.system(size: 20))
                                    
                                    Text("Add Image")
                                        .font(.headline)
                                    
                                    
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .padding()
                                
                            }
                            
                            
                        }
                    }.padding()
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                
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
                

                
                
            }.navigationBarTitle("Edit").toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    
                    Text("Cancel").foregroundColor(.red)
                    
                }
            }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        editCLothing(clothingToEdit: Clothing)
                        model.getClothing()
                        presentationMode.wrappedValue.dismiss()
                    }
                label: {
                    HStack{
                        Text("Save")
                    }
                }
            
        }
    }
    
        }
    }
    func editCLothing(clothingToEdit: Clothing){
        let storageRef = Storage.storage().reference()
        
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        
        var path = ""
        
        if imageData != nil {
            path = "\(self.Item)/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            fileRef.putData(imageData!, metadata: nil){ metadata,
                error in
                
                if error == nil && metadata != nil {
                    
                }

            }
            
            db.collection(user).document(clothingToEdit.id).setData(["Description":self.Description, "Item":self.Item,"Colour": self.Colour, "Weather": self.Weather,"Event": self.Event, "Gender": self.Gender,"Season": self.Season, "ImagePath": path],merge: true) { error in
                if error == nil {
                    model.getClothing()
                }
            }
        }
        else{
            path = "\(self.Item)/\(self.Item).jpg"
            db.collection(user).document(clothingToEdit.id).setData(["Description":self.Description, "Item":self.Item,"Colour": self.Colour, "Weather": self.Weather,"Event": self.Event, "Gender": self.Gender,"Season": self.Season, "ImagePath": path],merge: true) { error in
                if error == nil {
                    model.getClothing()
                }
            }
        }
        

    }
    
}


