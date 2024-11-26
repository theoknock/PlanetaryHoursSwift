//
//  MapView.swift
//  PlanetaryHoursSwift
//
//  Created by Xcode Developer on 11/26/24.
//

import SwiftUI
import CoreLocation
import MapKit
import Foundation

struct MapView: View {
    @State private var locationManager: LocationManager = LocationManager()
    
    var body: some View {
        Map {
            UserAnnotation()
        }
        .mapStyle(.imagery(elevation: .realistic))
    }
}

#Preview {
    MapView()
}
