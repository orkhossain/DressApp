//
//  LogInView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 29/04/2021.

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    var body: some View {
        Session()
    }

}

struct Session : View {
    @State var user = Auth.auth().currentUser
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View{

        NavigationView{

            VStack{

                if user != nil{

                    TabViews()
                }
                else{

                    ZStack{

                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {

                            Text("")
                        }
                        .hidden()

                        LogInChoser(show: .constant(false))
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {

                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in

                        self.user = Auth.auth().currentUser
                        self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

                    }
                }
            }
        }
    }


