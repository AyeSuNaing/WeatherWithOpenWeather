//
//  Extender.swift
//  WeatherwithOpenWeatherMap
//
//  Created by Brycen on 12/4/23.
//

import Foundation
import UIKit
import SwiftUI

extension UICollectionViewCell {
    static var identifier : String {
        return String(describing: self)
    }
}

extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}

extension UIView {
    func setGradientBackground(colors: [UIColor], locations: [NSNumber]? = nil, startPoint: CGPoint = CGPoint(x: 0.5, y: 0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}


extension UIViewController {
    
    static var identifier : String {
        return String(describing: self)
    }
    
    func setGradientBackground(for weatherCondition: WeatherCondition, in view: UIView) {
        var colors: [UIColor]
        
        switch weatherCondition {
        case .thunderstorm:
            colors = [UIColor(hex: "#4A148C"), UIColor(hex: "#7E57C2")] // Purple shades
        case .drizzle:
            colors =  [UIColor(hex: "#2196F3"), UIColor(hex: "#BBDEFB")] // Blue shades
        case .rain:
            colors =  [UIColor(hex: "#1565C0"), UIColor(hex: "#64B5F6")]  // Deep Blue shades
        case .snow:
            colors =  [UIColor(hex: "#FFFFFF"), UIColor(hex: "#B0BEC5")] // White to Light Gray
        case .atmosphere:
            colors =  [UIColor(hex: "#757575"), UIColor(hex: "#212121")]  // Gray to Black
        case .clear:
            colors =  [UIColor(hex: "#03A9F4"), UIColor(hex: "#424242")]  // Light Blue shades
        case .clouds:
            colors =  [UIColor(hex: "#9E9E9E"), UIColor(hex: "#424242")]  // Gray shades
        case .unknown:
            colors = [UIColor.white, UIColor.white] // Default to white
        }
        
        // Set gradient background with the selected colors
        view.setGradientBackground(colors: colors, locations: [0.0, 1.0])
    }
    
    
    func formatUnixTimestampToTime(timestamp: TimeInterval,_ isForeCast : Bool,_ timezone : TimeZone) -> String {
        // Convert timestamp to Date
        let date = Date(timeIntervalSince1970: timestamp)
        
        // Create a date formatter with the user's local timezone
        let dateFormatter = DateFormatter()
        if isForeCast {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
        } else {
            dateFormatter.dateFormat = "hh:mm a" // "a" represents AM/PM
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            
        }
        dateFormatter.timeZone = timezone // Use the local timezone
        
        return dateFormatter.string(from: date)
    }
    
    
    func displayAlertMessage(title:String?,message:String?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
// Extension to create Color from hex code
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}



extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

