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
                        
                        
                        ZStack{
                            LinearGradient(gradient:
                                            Gradient(colors: [ .yellow.opacity(0.5),
                                                               .orange.opacity(0.9)]),
                                           startPoint: .top, endPoint: .bottom)
                            
                        }.frame(width: UIScreen.main.bounds.width - 25, height:300, alignment: .center)
                            .cornerRadius(15)
                        
                        
                        //Current weather
                        Text("Current Weather").bold().font(.title2).padding(.top, 10)
                        
                        ZStack{
                            LinearGradient(gradient:
                                            Gradient(colors: [ .blue.opacity(0.5),
                                                               .blue.opacity(0.9)]),
                                           startPoint: .top, endPoint: .bottom)
                            
                        }.frame(width: UIScreen.main.bounds.width - 25, height:150, alignment: .center)
                            .cornerRadius(15)
                        
                  
                        Button(action: {
                            
                          
                        }) {
                            
                            Text("Create a new outfit").bold()
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 25)
                        }
                        .background(Color.green)
                        .cornerRadius(15)
                        .padding(.top, 10)
                       
                        
                        Button(action: {
                            
                        }) {
                            
                            Text("Suggest me an outfit").bold()
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 25)
                        }
                        .background(Color.orange)
                        .cornerRadius(15)
                      
                        
                          
                           
                           
                    }
                }.navigationBarTitle("Today's outfit")
            }.edgesIgnoringSafeArea(.all)
            
        }.navigationBarHidden(true)
    }
}


