//
//  LogInView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 29/04/2021.
//
import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    
    @State var user = Auth.auth().currentUser
    
    var body: some View {
        
        VStack{
            
            if user != nil{
                
                Home()
            }
            else{
                
                LogInPage()
            }
        }
        .onAppear {
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("SIGNIN"), object: nil, queue: .main) { (_) in
                
                self.user = Auth.auth().currentUser
            }
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
