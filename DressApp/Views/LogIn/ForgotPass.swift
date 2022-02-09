//
//  ForgotPass.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 21/01/2022.
//

import SwiftUI
import Firebase
import AuthenticationServices

struct ForgotPass: View {
    @State var email = ""
    @State var error = ""
    @State var empty = true
    @State var alert = false
    @State var color = Color.gray.opacity(0.7)
    
    var body: some View {
        
        ZStack{
            VStack {
            TextField("Email", text: self.$email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color.gray : self.color,lineWidth: 2))
                .padding(.top, 25)
                .frame(width: UIScreen.main.bounds.width - 50)
            
            Spacer()
            Button(action: {
                
                self.reset()
                
            }) {
                
                Text("Send link to update password")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)

            }.background(Color.red.opacity(0.8))
                    .cornerRadius(10)

                
            }.padding()
            Spacer()
        }
        
    }
    
    
    func reset(){
        
        if self.email != ""{
            
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                
                if err != nil{
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
                self.alert.toggle()
            }
        }
        else{
            
            self.error = "Email field is empty"
            self.alert.toggle()
        }
    }
    
    
}
