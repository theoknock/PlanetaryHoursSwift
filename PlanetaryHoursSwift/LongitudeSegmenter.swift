//
//  LongitudeSegmenter.swift
//  PlanetaryHoursSwift
//
//  Created by Xcode Developer on 11/26/24.
//

import Foundation

struct LongitudeSegmenter {
    struct Segment {
        let label: Int
        let start: Date
        let end: Date
    }
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
    }
    
    func calculateSegments(sunrise: Date, sunset: Date, nextDaySunrise: Date) -> [Segment] {
        var segments: [Segment] = []
        
        // Calculate day and night durations
        guard let dayDuration = calendar.dateComponents([.second], from: sunrise, to: sunset).second,
              let nightDuration = calendar.dateComponents([.second], from: sunset, to: nextDaySunrise).second else {
            return segments
        }
        
        let daySegmentDuration = dayDuration / 12
        let nightSegmentDuration = nightDuration / 12
        
        // Day segments (0 to 11)
        for i in 0..<12 {
            if let start = calendar.date(byAdding: .second, value: i * daySegmentDuration, to: sunrise),
               let end = calendar.date(byAdding: .second, value: daySegmentDuration, to: start) {
                segments.append(Segment(label: i, start: start, end: end))
            }
        }
        
        // Night segments (12 to 23)
        for i in 0..<12 {
            if let start = calendar.date(byAdding: .second, value: i * nightSegmentDuration, to: sunset),
               let end = calendar.date(byAdding: .second, value: nightSegmentDuration, to: start) {
                segments.append(Segment(label: i + 12, start: start, end: end))
            }
        }
        
        return segments
    }
    
    func formattedTime(for date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
