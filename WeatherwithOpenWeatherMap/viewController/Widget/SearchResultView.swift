//
//  SearchResultView.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 04/12/2023.
//

import Foundation
import SwiftUI
import Combine


struct SearchResultView: View {
    var result: SearchResult
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(result.displayName ?? "")
                .font(.caption)
            Text(result.name ?? "")
                .font(.caption2)
                .foregroundColor(.gray)
            Text("\(result.latitude ?? "") , \(result.longitude ?? "")")
                .font(.caption2)
                .foregroundColor(.gray)
            
        }
        
    }
}
