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
    
    @State private var showingSheet = false
    
    var body: some View {
        
        
        NavigationView
        {
            ZStack
            {
                
                HStack{
                    
                    WebImage(url: Auth.auth().currentUser?.photoURL)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10))
                        .scaledToFill()
                    
                    VStack(alignment: .leading, spacing: nil, content: {
                        
                        if (Auth.auth().currentUser != nil && Auth.auth().currentUser!.displayName != nil){
                            Text("\n\(Auth.auth().currentUser!.displayName!)").font(.system(size: 18)).bold()
                            Text("\n\(Auth.auth().currentUser!.email!)").font(.system(size: 14))}
                        else if (Auth.auth().currentUser != nil && Auth.auth().currentUser!.email != nil)
                        {Text("\n\(Auth.auth().currentUser!.email!)").font(.system(size: 14))}
                    } ).padding(.trailing, 15)
                    
                    
                    
                    
                }
                .cornerRadius(30)
                .frame(maxWidth: .infinity)
                Spacer()
                Spacer()
                
                
            }
            
            
            .toolbar{
                Button(action: {
                    showingSheet = true
                    
                }) {
                    
                    Text("Log out")
                    
                }
            } .actionSheet(isPresented: $showingSheet) {
                ActionSheet(
                    title: Text("Are you sure you want to log out?"),
                    buttons: [.destructive(Text("Sign Out"),
                                           action: logOut
                                           
                                           
                    ),
                    
                    .cancel()]
                )
            }
            
            
        }.edgesIgnoringSafeArea(.top)
        
    }
    
}

func logOut(){
    GIDSignIn.sharedInstance()?.signOut()
    try! Auth.auth().signOut()
    UserDefaults.standard.set(false, forKey: "status")
    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
    
}






