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
    @ObservedObject var Clothmodel = ClothviewModel()
    @ObservedObject var Outfitmodel = OutfitViewModel()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {

                NavigationView{
                    
                   ScrollView{ VStack(alignment: .leading){
                        
                        ZStack{
                            
                            if (Outfitmodel.list.count == 0 && Outfitmodel.list.count >= 2 && Clothmodel.list.count != 0){
                                NavigationLink {
                                    CreateOutfit(ClothList: Clothmodel.list)
                                } label: {
                                    VStack{
                                        Text("Create an Outfit").font(.title).bold()
                                        Image(systemName: "plus.circle").padding().font(.system(size: 60))
                                        
                                    }
                                }.foregroundColor(.black).opacity(0.5)
                            }
                            else if(Clothmodel.list.count < 2 ){
                                Text("Add 2 clothing items in the Add New tab to be able to create an outfit").padding().font(.title).foregroundColor(.black).opacity(0.5)
                            }
                            else
                            {
                            }
                            
                            
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
                            
                        }.frame(width: UIScreen.main.bounds.width - 25, height:150, alignment: .center)
                        
                        
                        if (Clothmodel.list.count >= 2){
                            NavigationLink(
                                destination:
                                    CreateOutfit(ClothList: Clothmodel.list),
                                label: {
                                    Text("Create a new outfit").bold()
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 25)
                                    
                                }).background(Color.green)
                                .cornerRadius(15)
                                .padding(.top, 10)
                            
                            
                            
                            if(Clothmodel.list.count >= 6){NavigationLink(
                                destination:
                                    SuggestOutfit(Weather: self.weatherVM.weather,maxTemp: self.weatherVM.temperature_max, minTemp: self.weatherVM.temperature_min),
                                label: {
                                    Text("Suggest me an outfit").bold()
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 25)
                                    
                                }).background(Color.orange)
                                .cornerRadius(15)}
                        }
                        
 
                        
                    }}.navigationBarTitle("Home")
                }.navigationViewStyle(.stack)
        
            .onAppear{
            Clothmodel.getClothing()
            Outfitmodel.getOutfits()
        }
    }
}


struct WeatherView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @StateObject var locationManager = LocationManager()
    
    let darkBlue =  Color(red: 0, green: 27/255, blue: 85/255)
    let darkRed =  Color(red: 288/255, green: 88/255, blue: 29/255)
    let darkOrange =  Color(red: 250/255, green: 209/255, blue: 110/255)
    
    
    
    var body: some View {
        
        
        ZStack{
            
            if (self.weatherVM.isNight == false){
                
                LinearGradient(gradient:
                                Gradient(colors: [ .blue.opacity(0.6),
                                                   .blue.opacity(0.9)]),
                               startPoint: .top, endPoint: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))}
            
            else if (self.weatherVM.isSunset == true){
                LinearGradient(gradient:
                                Gradient(colors: [darkBlue,darkOrange]),
                               startPoint: .top, endPoint: .bottom)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
            }
            
            else {
                LinearGradient(gradient:
                                Gradient(colors: [ darkBlue.opacity(0.8),
                                                   darkBlue]),
                               startPoint: .bottom, endPoint: .top)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))}
        }
        
        
        VStack(spacing: 5) {
            HStack{
                VStack{
                    Text("\(self.weatherVM.city)").font(.title2)
                    Text("\(self.weatherVM.temperature)").font(.title)
                }.foregroundColor(Color.white)
                
                
                
                Spacer()
                VStack{
                    self.weatherVM.icon
                        .font(.system(size: 35))
                    Text("\(self.weatherVM.weather)").font(.system(size: 15))
                }.foregroundColor(.white)
                
            }
            .padding(.leading, 5)
            .padding(.trailing, 5)
            
            
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
                    .background(LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .trailing, endPoint: .leading))
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
                }.foregroundColor(.white).padding(.leading, 5)
                
                
                Spacer()
                
                Picker(selection: self.$weatherVM.temperatureUnit, label: Text("Select a Unit")) {
                    ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                        Text(unit.title)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .frame(width: 60)
                
            }
        }.padding(5)
        
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


