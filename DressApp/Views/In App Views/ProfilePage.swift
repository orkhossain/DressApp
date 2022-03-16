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
    @State private var user = Auth.auth().currentUser!
    
    var body: some View {
        NavigationView{
            ZStack {
                
                
                VStack{
                    
                    Form{
                        
                        
                        HStack{
                            
                            if(user.photoURL == nil)
                            {
                                Circle().fill(Color.gray)
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 100, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .scaledToFill()
                            }
                            else {
                                WebImage(url: user.photoURL)
                                    .clipShape(Circle())
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 100, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .scaledToFill()}
                            
                            VStack(alignment:.leading,content: {
                                if (Auth.auth().currentUser != nil && Auth.auth().currentUser!.displayName != nil){
                                    VStack(spacing: 5){
                                        
                                        Text("\n\(user.displayName!)").font(.title3)
                                        Text("\n\(user.email!)").font(Font.system(size: 16))
                                    }.padding(.bottom, 10)
                                }
                                else if (Auth.auth().currentUser != nil && Auth.auth().currentUser!.email != nil)
                                {Text("\n\(Auth.auth().currentUser!.email!)").scaledToFill().font(.title3)
                                    
                                }
                            } )
                            
                        }
                        
                    }.navigationBarTitle("Profile")
                        .frame(minWidth: UIScreen.main.bounds.width - 25, maxWidth: .infinity)
                }
                
            }.navigationBarTitle("Profile")
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
                                           action: logOut),
                              
                                .cancel()]
                )
            }
        }
    }
    
    
}

func logOut(){
    GIDSignIn.sharedInstance()?.signOut()
    try! Auth.auth().signOut()
    UserDefaults.standard.set(false, forKey: "status")
    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
    
}






