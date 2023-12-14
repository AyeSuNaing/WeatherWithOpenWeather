//
//  DetailWeatherView.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 05/12/2023.
//

import SwiftUI

struct DetailWeatherView: View {
    @Environment(\.presentationMode) var presentationMode
    var weatherResult: CurrentWeatherResponse
    
    var body: some View {
        VStack (spacing : 0){
            Text(weatherResult.name ?? "")
                .font(.title)
                .foregroundColor(.black)
                .padding(.top, 20)
            HStack {
                Text("Lat : \(weatherResult.coord?.lat ?? 0.0)")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.trailing, 5)
                Text("Long : \(weatherResult.coord?.lon ?? 0.0)")
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .padding(.top, 20)
            
            WeatherImageView(imageUrl: "\(AppConstants.imgURl)\(weatherResult.weather?.first?.icon ?? "").png" )

            
            Text("\(String(format: "%.1f", (weatherResult.main?.temp ?? 0.0) - AppConstants.tempOffset))º")
                .font(.title)
                .foregroundColor(.black)
                .padding(.top, 20)
            HStack {
                Text("\(String(format: "%.1f", (weatherResult.main?.tempMax ?? 0.0) - AppConstants.tempOffset))º")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.trailing, 20)
                Text("\(String(format: "%.1f", (weatherResult.main?.tempMin ?? 0.0) - AppConstants.tempOffset))º")
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .padding(.top, 20)
            Text("Humidity: \(weatherResult.main?.humidity ?? 0)%")
                .font(.body)
                .foregroundColor(.black)
                .padding(.top, 20)
            Spacer()
        }
        
        .navigationBarTitle("Detail", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                    Text("Back")
                        .foregroundColor(.black)
                }
            }
        )
    }
    
}

