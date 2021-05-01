//
//  LogIn.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 30/04/2021.
//
import SwiftUI
import Firebase
import GoogleSignIn

struct LogInPage : View {
    
    @State var email = ""
    @State var password = ""
    @State var visible = false
    
    
    var body: some View{
        
        
        
        VStack(spacing: 15){
            Spacer()
            Text("DressApp")
                .font(.system(size: 44, weight: .semibold))
                .foregroundColor(.white)
            Spacer()
            
            ZStack{
                //This is the blurred background
                ZStack{}.frame(maxWidth: .infinity)
                    .frame(height:
                            350)
                    .background(Color.white)
                    .opacity(0.5)
                    .cornerRadius(45)
                //This is the content of the blur
                VStack(spacing: 15){
                    HStack{
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email)
                    }
                    .padding(.all, 15)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    
                    
                    HStack(spacing: 15){
                        
                        HStack{
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                            
                            if self.visible{
                                
                                TextField("Password", text: self.$password)
                                    .autocapitalization(.none)
                            }
                            else{
                                
                                SecureField("Password", text: self.$password)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            
                            self.visible.toggle()
                            
                        }) {
                            
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                            
                        }
                        
                    }.padding(.all, 15)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    
                    
                    
                    
                    HStack{
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.system(size: 24,weight:
                                            .medium))
                    }.frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    Button(action: {
                        
                        
                        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                        
                        GIDSignIn.sharedInstance()?.signIn()
                        
                        
                        
                    }, label: {
                        Text("Sign In WIth Google")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 24,weight:
                                            .medium))
                            .padding(.vertical, 10)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                    })
                }
                
            }
            
            Spacer()
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .background(Image("wallpaper")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    
        ).edgesIgnoringSafeArea(.all)
    }
}
