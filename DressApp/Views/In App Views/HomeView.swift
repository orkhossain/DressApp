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
    @ObservedObject private var weatherVM = WeatherViewModel()
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        GeometryReader {_ in
            NavigationView{
                ScrollView{
                    VStack(alignment: .leading){
                        
                        ZStack{
                            
                            
                        }.frame(width: UIScreen.main.bounds.width - 25, height:300, alignment: .center)
                            .background(LinearGradient(gradient:
                                                            Gradient(colors: [ .yellow.opacity(0.5),
                                                                               .orange.opacity(0.9)]),
                                                           startPoint: .top, endPoint: .bottom))
                            .cornerRadius(15)
                        
                        
                        //Current weather
                        Text("Current Weather").bold().font(.title2).padding(.top, 10)
                        
                        ZStack{
                            
                            
                            if let location = locationManager.location {
                                if #available(iOS 15.0, *) {
                                    if self.weatherVM.loadingState == .none
                                    {LoadView()
                                            .task {
                                                do {
                                                    self.weatherVM.fetchWeather(latitude: location.latitude, longitude: location.longitude)
                                                } catch {
                                                    print("Error getting weather: \(error)")
                                                }
                                            }}
                                    
                                    else if self.weatherVM.loadingState == .success {
                                        WeatherView(weatherVM: self.weatherVM)
                                    } else if self.weatherVM.loadingState == .failed {
                                        errorView(message: self.weatherVM.message)
                                    }
                                    
                                    
                                    
                                } else {
                                    // Fallback on earlier versions
                                }
                                
                            }
                            else{
                                WelcomeView()
                                    .environmentObject(locationManager)
                            }
                            
                            
                            
                            
                            
                            
                        }   .padding(10)
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                            .frame(width: UIScreen.main.bounds.width - 25, height:150, alignment: .center)
                            .background(LinearGradient(gradient:
                                                        Gradient(colors: [ .blue.opacity(0.5),
                                                                           .blue.opacity(0.9)]),
                                                       startPoint: .top, endPoint: .bottom)
                                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous)))
                        
                        
                        
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
    @StateObject var locationManager = LocationManager()
    
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            
            
            HStack{
                VStack{
                    Text("\(self.weatherVM.city)").font(.title2)
                    Text("\(self.weatherVM.temperature)").font(.title)
                }.foregroundColor(Color.white)
                    .padding(.top,25)
                
                
                Spacer()
                VStack{
                self.weatherVM.icon
                    .font(.system(size: 35))
                    Text("\(self.weatherVM.weather)").font(.system(size: 15))
                }.foregroundColor(.white)
                    .padding(.top, 20)
                    
            }
            
            
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "humidity.fill")
                        Text("\(self.weatherVM.humidity) humidity ")
                    }
                    HStack{
                        Image(systemName: "wind")
                        Text(" \(self.weatherVM.wind) M/s ")
                    }
                }
                
                Spacer()
                
                    VStack{
                        
                        VStack(alignment: .trailing) {
                            Text("")
                            .hidden()
                        }
                        .frame(width: 100, height: 3)
                        .background(LinearGradient(gradient: Gradient(colors: [.green, .red]), startPoint: .trailing, endPoint: .leading))
                        .cornerRadius(10)
                        HStack{
                        Text("\(self.weatherVM.temperature_max)")
                        Text("\(self.weatherVM.temperature_min)")
                            
                        }
                    }
                }.foregroundColor(Color.white)
                    .opacity(0.7)
            
            
            
            HStack{
                
                    HStack{
                        Image(systemName:"location.fill").font(.system(size: 12))
                        Text("Using your current position").font(.system(size: 15))
                    }.foregroundColor(.white)
                
                
                Spacer()
                
                Picker(selection: self.$weatherVM.temperatureUnit, label: Text("Select a Unit")) {
                    ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                        Text(unit.title)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .frame(width: 60)

                
            }.padding(.bottom, 25)

        }
    }
}


struct errorView: View {
    
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.body)
                .foregroundColor(Color.white)
            
        }
        .padding()
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

struct LoadView: View{
    var body: some View{
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .black))
    }
}


