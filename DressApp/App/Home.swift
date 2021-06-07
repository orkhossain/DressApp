//
//  Home.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 30/04/2021.
//
import SwiftUI
import Firebase
import GoogleSignIn

struct Home : View {
    
    
 
    
    var body: some View{
        
        ZStack{
            
            
            

                        
        }.navigationTitle("DRESSAPP").font(.title).edgesIgnoringSafeArea(.all)
    

        HStack {
            TabView() {
                Text("Hello").tabItem{
                    Label("Home",systemImage:"house.fill")
                }.tag(1)
                Text("Tab Content 1").tabItem {
                    Label("Wardrobe",systemImage:"square.grid.2x2.fill")
                }.tag(4)
                Text("Tab Content 2").tabItem {
                    Label("Add new",systemImage:"plus.app")
                }.tag(3)
 
                Text("Tab Content 3").tabItem {
                    Label("Your favourite",systemImage:"heart")
                }.tag(2)
                Profile().tabItem {
                    Label("Account",systemImage:"person.crop.circle.fill")
                }.tag(5)
                
            }
            
        }
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
