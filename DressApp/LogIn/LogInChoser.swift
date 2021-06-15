//
//  LogInChose.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 13/05/2021.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LogInChoser: View {
    
    @Binding var show : Bool
    
    var body: some View {
        
        
        NavigationView {
           
            ZStack{
                
            
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Button(action: {

                        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                        GIDSignIn.sharedInstance()?.signIn()
                        UserDefaults.standard.set(true, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)



                    }, label: {
                        Text("Sign In WIth Google")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)

                    })
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(10)

                    
                    NavigationLink(
                        destination:
                            LogInPage(show: .constant(true)),
                        label: {
                            HStack{
                                Image(systemName: "envelope.fill")
                                Text("Log In with email")}.foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }) .background(Color.blue)
                        .cornerRadius(10).padding(.top,15)

                    
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: SignUp( show: .constant(true)),
                        label: {
                            HStack{
                                Text("Don't have an account yet?")
                                Text("Register").bold()
                            }
                            .foregroundColor(.blue)
                        }).padding(.bottom, 25)
                }
            }.ignoresSafeArea(.all)
                
            }.navigationBarHidden(true)
    }
}
