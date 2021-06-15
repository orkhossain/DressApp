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
            Color.yellow
                       .opacity(0.4)
                       .edgesIgnoringSafeArea(.all)
                        .frame(height:80)
        Text("DRESSAPP").font(.title).bold().foregroundColor(.black)
        }
    
        
        
        HStack {
            TabView() {
                Text("Hello").tabItem{
                    Label("Home",systemImage:"house.fill")
                }.tag(1)
                Text("Tab Content 3").tabItem {
                    Label("Wardrobe",systemImage:"square.grid.2x2.fill")
                }.tag(2)
                Text("Tab Content 2").tabItem {
                    Label("Add new",systemImage:"plus.app")
                }.tag(3)
                Text("Tab Content 3").tabItem {
                    Label("Favourite",systemImage:"heart.fill")
                }.tag(4)
                Profile().tabItem {
                    Label("Profile",systemImage:"person.crop.circle.fill")
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
