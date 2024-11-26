//
//  PlanetaryHourView.swift
//  PlanetaryHoursSwift
//
//  Created by Xcode Developer on 11/26/24.
//

import SwiftUI

struct PlanetaryHourView: View {
    @Bindable var planetaryHourSegmenter: PlanetaryHourSegmenter

    var body: some View {
        List(planetaryHourSegmenter.segments) { segment in
            VStack(alignment: .leading, spacing: 8) {
                Text("Hour \(segment.label)")
                    .font(.headline)
                Text("Start: \(segment.start.formatted(.dateTime))")
                Text("End: \(segment.end.formatted(.dateTime))")
            }
            .padding()
            .background(segment.label == 12 ? Color.yellow.opacity(0.3) : Color.blue.opacity(0.3))
            .cornerRadius(8)
        }
        .background(Color.clear)
        .scrollContentBackground(Visibility.hidden)
    }
}
