//
//  PlanetaryHourSegmenter.swift
//  PlanetaryHoursSwift
//
//  Created by Xcode Developer on 11/26/24.
//

import Foundation
import Observation

@Observable
class PlanetaryHourSegmenter {
    
    struct PlanetaryHourSegment: Identifiable {
        let id = UUID() // Add `id` for `Identifiable`
        let label: Int
        let start: Date
        let end: Date
    }
    
    public var segments: [PlanetaryHourSegment] = []
    
    init(segments: [PlanetaryHourSegment]) {
        self.segments = segments
    }
    
    func calculatePlanetaryHourSegments(sunrise: Date, sunset: Date, nextDaySunrise: Date) {
        segments.removeAll() // Clear existing segments before appending
        for i in 0..<12 {
            let start = Date(timeIntervalSince1970: normalize(index: Double(i), rangeMin: sunrise.timeIntervalSince1970, rangeMax: sunset.timeIntervalSince1970, firstIndex: 0, lastIndex: 12))
            let end = Date(timeIntervalSince1970: normalize(index: Double(i + 1), rangeMin: sunrise.timeIntervalSince1970, rangeMax: sunset.timeIntervalSince1970, firstIndex: 0, lastIndex: 12))
            segments.append(PlanetaryHourSegment(label: i, start: start, end: end))
        }
        
        for i in 0..<12 {
            let start = Date(timeIntervalSince1970: normalize(index: Double(i), rangeMin: sunset.timeIntervalSince1970, rangeMax: nextDaySunrise.timeIntervalSince1970, firstIndex: 0, lastIndex: 12))
            let end = Date(timeIntervalSince1970: normalize(index: Double(i + 1), rangeMin: sunset.timeIntervalSince1970, rangeMax: nextDaySunrise.timeIntervalSince1970, firstIndex: 0, lastIndex: 12))
            segments.append(PlanetaryHourSegment(label: i + 11, start: start, end: end))
        }
    }

    func normalize(index: Double, rangeMin: Double, rangeMax: Double, firstIndex: Double, lastIndex: Double) -> Double {
        return (rangeMax - rangeMin) * (index - firstIndex) / (lastIndex - firstIndex) + rangeMin
    }
}
