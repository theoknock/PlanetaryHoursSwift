//
//  NewContentView.swift
//  PlanetaryHoursSwift
//
//  Created by Xcode Developer on 11/26/24.
//

import SwiftUI
import CoreLocation
import MapKit
import Foundation
import Observation

struct NewContentView: View {
    @State private var sunrise: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
    @State private var sunset: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
    @State private var nextDaySunrise: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
    @State private var date: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
    @State private var showResults = false
    
    var body: some View {
        ZStack(alignment: Alignment.center, content: {
            HStack(content: {
                MapView()
            })
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: Alignment.center)
            
            HStack(content: {
                CalendarView()
            })
            .fixedSize()
        })
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: Alignment.center)
    }
}

#Preview {
    NewContentView()
        .preferredColorScheme(.dark)
}
