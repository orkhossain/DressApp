//@ -1,80 +0,0 @@
//
//  HomeView.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 10/08/2021.
//

import SwiftUI
import CoreLocationUI

struct HomeView: View {
    @ObservedObject private var weatherVM: WeatherViewModel
    @State private var city: String = ""
    
    init(weatherVM: WeatherViewModel = WeatherViewModel()) {
        self.weatherVM = weatherVM
    }
    
    @StateObject var locationManager = LocationManager()
    
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
                            
                            
                            //                            LinearGradient(gradient:
                            //                                            Gradient(colors: [ .blue.opacity(0.5),
                            //                                                               .blue.opacity(0.9)]),
                            //                                           startPoint: .top, endPoint: .bottom)
                            //
                            
                            if let location = locationManager.location {
                                Button {
                                    // perform a fetch weather using the city name
                                    let lat = Double(location.latitude)
                                    let long = Double(location.longitude)
                                    self.weatherVM.fetchWeather(latitude: lat, longitude: long)
                                    
                                } label: {
                                    Text("Get weather")
                                }.frame(width: UIScreen.main.bounds.width - 25, alignment: .center)
                            }
                            else{
                                
                                WelcomeView()
                                    .environmentObject(locationManager)
                            }
                            
                            
                            //                            if self.weatherVM.loadingState == .loading {
                            //                                LoadingView()
                            //                            } else
                            if self.weatherVM.loadingState == .success {
                                WeatherView(weatherVM: self.weatherVM)
                            } else if self.weatherVM.loadingState == .failed {
                                errorView(message: self.weatherVM.message)
                            }
                            
                            
                            
                            
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


struct WeatherView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 160){
            VStack(){
                Text("\(self.weatherVM.city)").font(.title2)
                Text("\(self.weatherVM.temperature)").font(.title)
            }.foregroundColor(Color.white)
                
//                AsyncImage(url: URL(string: T##__shared))
//                Text("\(self.weatherVM.icon)")
            }
            
            Text("\(self.weatherVM.humidity) Humidity")
                .foregroundColor(Color.white)
                .opacity(0.7)
            HStack{
                Text("\(self.weatherVM.temperature_max)")
                Text("\(self.weatherVM.temperature_min)")
            }.foregroundColor(Color.white)
                .opacity(0.7)
            Picker(selection: self.$weatherVM.temperatureUnit, label: Text("Select a Unit")) {
                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                    Text(unit.title)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .frame(width: 60, alignment: .trailing)
                .padding(.leading, 260)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 25, height:300, alignment: .center)
        .background(LinearGradient(gradient:
                                    Gradient(colors: [ .blue.opacity(0.5),
                                                       .blue.opacity(0.9)]),
                                   startPoint: .top, endPoint: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous)))
        
    }
}

//struct LoadingView: View {
//    var body: some View {
//        VStack {
//            Text("Loading your amazing weather!")
//                .font(.body)
//                .foregroundColor(Color.white)
//
//        }
//        .padding()
//        .frame(width: UIScreen.main.bounds.width - 25, height:300, alignment: .center)
//        .background(Color.orange)
//        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
//
//    }
//}

struct errorView: View {
    
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.body)
                .foregroundColor(Color.white)
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 25, height:300, alignment: .center)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
        
    }
}

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        
        if #available(iOS 15.0, *) {
            LocationButton(.shareCurrentLocation){
                locationManager.requestLocation()
            } .cornerRadius(30).symbolVariant(.fill).foregroundColor(.white)
            
        } else {
            // Fallback on earlier versions
        }
        
    }
}

//struct LoadView: View{
//    var body: some View{
//        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .black))
//    }
//}

