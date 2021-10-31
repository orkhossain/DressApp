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
                
                HStack {
                    TabView{
                        HomeView().navigationBarHidden(true).tabItem{
                            Label("Home",systemImage:"house.fill")
                        }.tag(1)
                        Wardrobe().navigationBarHidden(true).tabItem {
                            Label("Wardrobe",systemImage:"square.grid.2x2.fill")
                        }.tag(2)
                        AddNew().navigationBarHidden(true).tabItem {
                            Label("Add new",systemImage:"plus.app")
                        }.tag(3)
                        Text("Tab Content 3").tabItem {
                            Label("Favourite",systemImage:"suit.heart.fill")
                        }.tag(4)
                        Profile().navigationBarHidden(true).tabItem {
                            Label("Profile",systemImage:"person.crop.circle.fill")
                        }.tag(5)
                        
                    }.navigationBarHidden(true)
                }.navigationBarHidden(true)
            }
    }
}




   
