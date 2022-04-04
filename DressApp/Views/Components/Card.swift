//
//  CardView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 13/02/2022.
//

import SwiftUI
import Firebase

struct CardView: View {
    
    @State var item: Clothing
    @State private var clothImage = UIImage()
    
    var body: some View {
        
        VStack{
            
            
            ZStack(alignment: .bottom){
                
                Image(uiImage: clothImage).resizable().scaledToFill()
                    .frame(minWidth: 110, idealWidth: 120, maxWidth: 150, minHeight: 170, idealHeight: 180, maxHeight:200, alignment: .leading)
                    .cornerRadius(16)
                
                
                VStack{
                    NavigationLink(
                destination:
                    ClothView(item: item, image: clothImage),
                label: {
                    Text("fansjfha").foregroundColor(.white).opacity(0.0).frame(width: 150, height: 100 )
                })
                    
                } .frame(minWidth: 110, idealWidth: 120, maxWidth: 150, minHeight: 170, idealHeight: 180, maxHeight:200, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1))
                
            }
            
            
            
        }.onAppear{
            getImage(path: item.Image)
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



struct OutfitCardView: View {
    @State var imagePath: String
    @State private var clothImage = UIImage()

    var body: some View {
        VStack{
            Image(uiImage: clothImage).resizable()
                .frame(minWidth: 130, idealWidth: 140, maxWidth: 160, minHeight: 170, idealHeight: 180, maxHeight:200, alignment: .leading)            .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .cornerRadius(16)
                .scaledToFill()

            
        }.frame(minWidth: 130, idealWidth: 140, maxWidth: 160, minHeight: 170, idealHeight: 180, maxHeight:200, alignment: .leading)
.onAppear{
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
