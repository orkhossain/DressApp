//
//  SwiftUIView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 30/04/2021.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SDWebImageSwiftUI

struct Profile: View {
    
    
    var body: some View {

        ZStack{
            Color(red: 255/255, green: 246/255, blue: 212/255)
            
            HStack(alignment: .top){
                WebImage(url: Auth.auth().currentUser?.photoURL)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10))
                    .scaledToFill()
                
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text("\n\(Auth.auth().currentUser!.displayName!)").font(.system(size: 20)).bold().foregroundColor(.black)
                    Text("\n\(Auth.auth().currentUser!.email!)").font(.system(size: 14)).foregroundColor(.black)
                } ).padding(.trailing, 15)
                
                
            }
            .cornerRadius(30)
            .frame(maxWidth: .infinity)
            Spacer()
            Spacer()
        }
    

        
    }
    
}


