//
//  SaveWeatherSwiftUIView.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 05/12/2023.
//

import SwiftUI
import Combine


struct SaveWeatherSwiftUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = SaveViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.saveResults, id: \.id) { result in
                    NavigationLink(destination: DetailWeatherView(weatherResult: result)) {
                        WeatherListItemView(weatherResult: result)
                    }
                    
                    
                }
            }
            .navigationBarTitle("Saved Weather", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    // Handle back button action
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black) // Set the color of the Image
                    Text("Back")
                        .foregroundColor(.black)
                }
            )
            .background(Color(.systemGray6))
        }
    }
}
