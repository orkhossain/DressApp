//
//  Wardrobe.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 30/06/2021.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase


struct Wardrobe: View {
    // let db = Firestore.firestore()
    
    private var symbols = [
        "Shirts", "T-Shirts", "Polo", "Trousers", "Jackets", "Jumpers", "Hoodies", "Coats", "Cardigans", "Jeans"]
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        GeometryReader { _ in
            
            NavigationView{
                
                VStack{
                    
                    Spacer()
                    
                    ZStack{
                        
                        
                        Color.gray
                            .opacity(0.1)
                            .cornerRadius(15)
                            .frame(width: UIScreen.main.bounds.width - 20, height: 230)
                        
                        VStack(alignment: .leading){
                            
                            Text("Your Favourite Outfits").font(.title).bold().foregroundColor(.blue)
                                .padding(.top,15)
                                .padding(.leading,20)
                            
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment:.top) {
                                    ForEach(0..<10) {
                                        Text("Your favourite Outfits \n \($0)")
                                            .foregroundColor(.white).font(.title2)
                                            .frame(width: 120, height: 150)
                                            .background(Color.red)
                                            .cornerRadius(15).padding(.leading, 15)
                                            .shadow(color: .gray.opacity(2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 10)
                                    }
                                }.frame(height: 160).padding(.bottom, 15)
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                    ZStack{
                        GeometryReader {_ in
                            Color.red
                            
                            VStack(alignment: .leading){
                                HStack(alignment: .top){
                                    Text("Categories").font(.largeTitle).bold().padding().foregroundColor(.white)
                                }
                                
                                
                                ScrollView {
                                    LazyVGrid(columns: gridItemLayout, spacing: 25) {
                                        ForEach((0...symbols.count-1), id: \.self) {
                                            Text(symbols[$0 % symbols.count]).bold()
                                                .padding(10)
                                                .frame(width: 160, height: 50, alignment: .leading)
                                                .background(Color.white).cornerRadius(10)
                                            
                                        }
                                    }
                                }.padding(.leading, 10)
                                .padding(.trailing, 10)
                                .padding(.bottom, 20)
                                
                            }
                        }
                        
                        
                    }
                    .cornerRadius(15)
                    .padding(10)
                    
                    //        db.collection("\(user)").getDocuments() { (querySnapshot, err) in
                    //            if let err = err {
                    //                print("Error getting documents: \(err)")
                    //            } else {
                    //                for document in querySnapshot!.documents {
                    //                    print("\(document.documentID) => \(document.data())")
                    //                }
                    //            }
                    //        }
                    
                }.navigationTitle("Your Wardrobe")
                .foregroundColor(.black)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                
            }
        }
        
    }
    
}

