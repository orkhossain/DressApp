//
//  Folder.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 29/03/2022.
//

import SwiftUI
import Firebase

struct Folder: View {
    @State var outfitImages : [String]
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @State var clothImage = [UIImage]()
    
    var body: some View {
        LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach(clothImage, id: \.self) { image in
                    
                Image(uiImage: image).resizable()
                        .frame(width: 60, height: 80, alignment: .leading)
                        .scaledToFill()
                        .cornerRadius(6)
            }
            
        }.onAppear{
            if clothImage == []{
            getImages(imagesPath: outfitImages)
            }
            
            
        }

        
    }
    
    
    
    
    
    
    
    func getImages(imagesPath: [String]){
        
        for path in imagesPath{
            let storageRef = Storage.storage().reference()
            let fileRef = storageRef.child(path)
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                if error == nil && data != nil {
                    if let image = UIImage(data: data!){
                        DispatchQueue.main.async{
                            clothImage.append(image)
                        }
                        
                    }
                }
            }
        }
    }
}

