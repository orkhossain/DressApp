//
//  HomeView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 10/08/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader {_ in
            NavigationView{
                ScrollView{
                    VStack(alignment: .leading){
                        HStack{
                            Text("Outfit of the day").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.leading, 10)
                        }
                    }
                }.navigationBarHidden(true)
            }
            
        }
    }
}


