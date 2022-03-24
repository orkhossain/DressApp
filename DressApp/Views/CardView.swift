//
//  CardView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 13/02/2022.
//

import SwiftUI
import Firebase

struct CardView: View {
    
    @ObservedObject private var model =  ClothviewModel()
    @State var item: Clothing
    @State private var clothImage = UIImage()
    
    var body: some View {
        
        VStack{
            
            
            ZStack(alignment: .bottom){
                Image(uiImage: clothImage).resizable().scaledToFill()
                    .frame(minWidth: 130, idealWidth: 150, maxWidth: 160, minHeight: 170, idealHeight: 185, maxHeight:200, alignment: .leading)
                    .cornerRadius(16)
                
                
                VStack{
                    NavigationLink(
                destination:
                    ClothView(item: item, image: clothImage),
                label: {
                    Text("fansjfha").foregroundColor(.white).opacity(0.0).frame(width: 150, height: 100 )
                })

                
                    HStack{
                        Text("\(item.Item)").foregroundColor(.blue)
                        Spacer()
                        Button {
                            model.setFavourite(item: item)
                        } label: {
                            if (item.Favourite == true) {
                                Image(systemName: "heart.fill")}
                            else {
                                Image(systemName: "heart")}
                        }
                        
                    }.padding() .buttonStyle(BorderlessButtonStyle())}
                
            }
            
            
            
        }.onAppear{
            getImage(path: item.Image)
        }
        .frame(minWidth: 130, idealWidth: 150, maxWidth: 160, minHeight: 170, idealHeight: 185, maxHeight:200, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1))
        
        
        
    }
    
    
    func getImage(path: String){
        
        let storageRef = Storage.storage().reference()
        
        let fileRef = storageRef.child(path)
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                if let image = UIImage(data: data!){
                    DispatchQueue.main.async{
                        clothImage = image
                    }
                    
                }
            }
        }
    }
}



struct OutfitCardView: View {
    
    @ObservedObject var model = ClothviewModel()
    @State var item: String
    @State var imagePath: String
    @State private var clothImage = UIImage()

    var body: some View {
        VStack{
            Image(uiImage: clothImage).resizable()
                .frame(width: 160, height: 200, alignment: .leading)
                .cornerRadius(16)
                .scaledToFill()

            
        }.frame(width: 160, height: 200, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 1)
            ).onAppear{
            getImage(path: imagePath)
        }
    }
    
    func getImage(path: String){
        
        let storageRef = Storage.storage().reference()
        
        let fileRef = storageRef.child(path)
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                if let image = UIImage(data: data!){
                    DispatchQueue.main.async{
                        clothImage = image
                    }
                    
                }
            }
        }
    }
}
