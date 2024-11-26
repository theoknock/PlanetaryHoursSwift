//
//  CalendarView.swift
//  PlanetaryHoursSwift
//
//  Created by Xcode Developer on 11/26/24.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var locationManager: LocationManager = LocationManager()
    @State private var sunrise: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
    @State private var sunset: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
    @State private var nextDaySunrise: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
    //    @State private var hours: [PlanetaryHourSegmenter.PlanetaryHourSegment] = []
    //    @State private var longitudes: [LongitudeSegmenter.Segment] = []
    @State private var date: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
    @State private var showResults = false // Add this state variable
    let calculator = SunriseSunsetCalculator()
    @State private var planetaryHourSegmenter: PlanetaryHourSegmenter = PlanetaryHourSegmenter(segments: [])
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, content: {
            ScrollView {
                Text("Sunrise and Sunset Calculator")
                    .scaledToFill()
                    .dynamicTypeSize(.xxxLarge)
                    .padding(.top, 50)
                    .foregroundColor(Color.white)
                
                DatePicker("Select Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                    .foregroundColor(Color.white)
                
                if let location = locationManager.location {
                    Text("Latitude: \(location.coordinate.latitude)")
                    Text("Longitude: \(location.coordinate.longitude)")
                    
                    Button("Calculate") {
                        sunrise = calculator.calculateSunrise(for: date, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)!
                        
                        sunset = calculator.calculateSunset(for: date, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)!
                        
                        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                        nextDaySunrise = calculator.calculateSunrise(for: nextDay, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)!
                        
                        //                    let segmenter = DayNightSegmenter()
                        
                        planetaryHourSegmenter.calculatePlanetaryHourSegments(sunrise: sunrise, sunset: sunset, nextDaySunrise: nextDaySunrise)
                        
                        showResults = true // Set to true when calculate button is tapped
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                } else {
                    Text("Getting location...")
                }
                
                if showResults { // Conditionally show sunrise and sunset
                    TextField("\(sunrise.formatted(.dateTime))", text: Binding<String>(
                        get: { sunrise.formatted(.dateTime) },
                        set: { newString in
                            if let newDate = DateFormatter().date(from: newString) {
                                sunrise = newDate
                            }
                        }
                    ))
                    TextField("\(sunset.formatted(.dateTime))", text: Binding<String>(
                        get: { sunset.formatted(.dateTime) },
                        set: { newString in
                            if let newDate = DateFormatter().date(from: newString) {
                                sunset = newDate
                            }
                        }
                    ))
                    TextField("\(nextDaySunrise.formatted(.dateTime))", text: Binding<String>(
                        get: { nextDaySunrise.formatted(.dateTime) },
                        set: { newString in
                            if let newDate = DateFormatter().date(from: newString) {
                                nextDaySunrise = newDate
                            }
                        }
                    ))
                }
            }
        })
        .sheet(isPresented: $showResults) {
            TextField("\(sunrise.formatted(.dateTime))", text: Binding<String>(
                get: { sunrise.formatted(.dateTime) },
                set: { newString in
                    if let newDate = DateFormatter().date(from: newString) {
                        sunrise = newDate
                    }
                }
            ))
            TextField("\(sunset.formatted(.dateTime))", text: Binding<String>(
                get: { sunset.formatted(.dateTime) },
                set: { newString in
                    if let newDate = DateFormatter().date(from: newString) {
                        sunset = newDate
                    }
                }
            ))
            TextField("\(nextDaySunrise.formatted(.dateTime))", text: Binding<String>(
                get: { nextDaySunrise.formatted(.dateTime) },
                set: { newString in
                    if let newDate = DateFormatter().date(from: newString) {
                        nextDaySunrise = newDate
                    }
                }
            ))
            PlanetaryHourView(planetaryHourSegmenter: planetaryHourSegmenter)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: Alignment.center)
        }
        .onAppear {
            locationManager.requestLocation()
        }
    }
}

#Preview {
    CalendarView()
}
