//
//  SearchSwiftUIView.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 04/12/2023.
//


import SwiftUI
import Combine


struct SearchSwiftUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = SearchViewModel()
    
    var onItemSelected: ((Double, Double) -> Void)?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibility(identifier: "SearchSwiftUIViewIdentifier")
                
                List(viewModel.searchResults) { result in
                    SearchResultView(result: result)
                    
                    .accessibility(identifier: "SearchSwiftUIListIdentifier")
                        .onTapGesture {
                            // Call the callback to pass latitude and longitude
                            onItemSelected?(Double(result.latitude ?? "0.0") ?? 0.0, Double(result.longitude ?? "0.0") ?? 0.0)
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
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

//
//#Preview {
//    SearchSwiftUIView()
//}
