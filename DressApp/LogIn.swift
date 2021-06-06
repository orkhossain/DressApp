//
//  LogIn.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 30/04/2021.
//
import SwiftUI
import Firebase
import GoogleSignIn
import AuthenticationServices



struct LogInPage : View {
    
    
    @State var color = Color.gray.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        
        
        NavigationView{
        
        ZStack{
            
            
            ZStack(alignment: .topTrailing) {
                

                GeometryReader{_ in
                    
                    ZStack{

                    VStack{

                        Text("Log In")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 70)
                        
                        TextField("Email", text: self.$email)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color.white : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.visible{
                                    
                                    TextField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                                }
                                else{
                                    
                                    SecureField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color.white : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        
                        
                        HStack{
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.reset()
                                
                            }) {
                                
                                Text("Forget password?")
                                    .fontWeight(.bold)
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding(.top, 20)

                        
                        Button(action: {
                            
                            self.verify()
                            
                        }) {
                            
                            Text("Log in")
                                
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 25)
                        
                        
                        Text("or").font(.title3)
                        
                        
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
                      
                    
                        Spacer()
                        
                        
                        NavigationLink(
                            destination: SignUp( show: .constant(true)),
                            label: {
                                HStack{
                                    Text("Have an account already?")
                                    Text("Sign Up").bold()
                                }
                                .foregroundColor(Color.blue)
                            }).padding(.bottom, 25)
                           
                        
                        
                    }
                    
                    
                    .padding(.horizontal, 25)
                }
            }
                
            }
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
            
        }.edgesIgnoringSafeArea(.all)
       
        

        }.navigationBarHidden(true)
        
    }
    
    
    func verify(){
        
        if self.email != "" && self.pass != ""{
            
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                
                if err != nil{
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
             
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else{
            
            self.error = "Please fill in"
            self.alert.toggle()
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
        
