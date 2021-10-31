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
                
                
                VStack{
                    
                    Form{
                    
                    
                    HStack{
                        
                        WebImage(url: Auth.auth().currentUser?.photoURL)
                            .clipShape(Circle()).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 10, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .scaledToFill()
                            
                        VStack(alignment: .leading, spacing: nil, content: {
                            if (Auth.auth().currentUser != nil && Auth.auth().currentUser!.displayName != nil){
                                Text("\n\(Auth.auth().currentUser!.displayName!)").bold().scaledToFill()
                                Text("\n\(Auth.auth().currentUser!.email!)").scaledToFill()}
                            else if (Auth.auth().currentUser != nil && Auth.auth().currentUser!.email != nil)
                            {Text("\n\(Auth.auth().currentUser!.email!)").scaledToFill()}
                        } )
                        
                        
                        
                    }
                    .padding()
                    .cornerRadius(30)
                    .frame(maxWidth: .infinity)
                    Spacer()
                    Spacer()
                    
                    
                    }
            }
            
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






