//
//  WeatherListItemView.swift
//  WeatherwithOpenWeatherMap
//
//  Created by Brycen on 12/5/23.
//

import Foundation
import SwiftUI

struct WeatherListItemView: View {
    var weatherResult: CurrentWeatherResponse
    
    var body: some View {
        HStack {
            WeatherImageView(imageUrl: "\(AppConstants.imgURl)\(weatherResult.weather?.first?.icon ?? "").png" )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(weatherResult.name ?? "")
                    .font(.headline)
                
                Text("\(weatherResult.coord?.lat ?? 0.0) , \(weatherResult.coord?.lat ?? 0.0)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
       
    }
}


struct WeatherImageView: View {
    var imageUrl : String = ""
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)!){
            phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 70, height: 70)
                
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 70, height: 70)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(3)
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                    .frame(width: 70, height: 70)
                
            @unknown default:
                EmptyView()
            }
        }
        
    }
}

