////
////  ContentView.swift
////  PlanetaryHoursSwift
////
////  Created by Xcode Developer on 11/26/24.
////
//
//import SwiftUI
//import CoreLocation
//import MapKit
//import Foundation
//
//
//
//struct ContentView: View {
////    @StateObject private var locationManager = LocationManager()
//    @State private var sunrise: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
//    @State private var sunset: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
//    @State private var nextDaySunrise: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
//    @State private var hours: [PlanetaryHourSegmenter.PlanetaryHourSegment] = []
//    @State private var longitudes: [LongitudeSegmenter.Segment] = []
//    @State private var date: Date = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: Date())))
//    @State private var showResults = false // Add this state variable
//    let calculator: SunriseSunsetCalculator = SunriseSunsetCalculator()
//    let planetaryHourSegmenter: PlanetaryHourSegmenter = PlanetaryHourSegmenter()
//    
//    private func calculateFontSize(for width: CGFloat) -> CGFloat {
//        max(10, min(20, width)) // Adjust the divisor to control scaling
//    }
//    
//    var body: some View {
//        Color.blue.edgesIgnoringSafeArea(.all)
//        ZStack(content: {
//            HStack(alignment: .center, content: {
//                Map {
//                    UserAnnotation()
//                }
//                .ignoresSafeArea()
//                .mapStyle(.imagery(elevation: .realistic))
//            })
//            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//            
//            ScrollView {
//                VStack(content: {
//                    HStack(alignment: .top, content: {
//                        VStack(content: {
//                            
//                            Text("Sunrise and Sunset Calculator")
//                                .scaledToFill()
//                                .dynamicTypeSize(.xxxLarge)
//                            //                                .safeAreaPadding(.top)
//                                .padding(.top, 50)
//                                .foregroundColor(Color.white)
//                            
//                            DatePicker("Select Date", selection: $date, displayedComponents: .date)
//                                .datePickerStyle(GraphicalDatePickerStyle())
//                                .padding()
//                            
//                                .foregroundColor(Color.white)
//                            
//                            if let location = locationManager.location {
//                                Text("Latitude: \(location.coordinate.latitude)")
//                                Text("Longitude: \(location.coordinate.longitude)")
//                                
//                                Button("Calculate") {
//                                    sunrise = calculator.calculateSunrise(for: date, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)!
//                                    
//                                    sunset = calculator.calculateSunset(for: date, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)!
//                                    
//                                    let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)!
//                                    nextDaySunrise = calculator.calculateSunrise(for: nextDay, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)!
//                                    
//                                    //                    let segmenter = DayNightSegmenter()
//                                    
//                                    hours = planetaryHourSegmenter.calculatePlanetaryHourSegments(sunrise: sunrise, sunset: sunset, nextDaySunrise: nextDaySunrise)
//                                    
//                                    showResults = true // Set to true when calculate button is tapped
//                                }
//                                .padding()
//                            } else {
//                                Text("Getting location...")
//                            }
//                            
//                            if showResults { // Conditionally show sunrise and sunset
//                                TextField("\(sunrise.formatted(.dateTime))", text: Binding<String>(
//                                    get: { sunrise.formatted(.dateTime) },
//                                    set: { newString in
//                                        if let newDate = DateFormatter().date(from: newString) {
//                                            sunrise = newDate
//                                        }
//                                    }
//                                ))
//                                TextField("\(sunset.formatted(.dateTime))", text: Binding<String>(
//                                    get: { sunset.formatted(.dateTime) },
//                                    set: { newString in
//                                        if let newDate = DateFormatter().date(from: newString) {
//                                            sunset = newDate
//                                        }
//                                    }
//                                ))
//                                TextField("\(nextDaySunrise.formatted(.dateTime))", text: Binding<String>(
//                                    get: { nextDaySunrise.formatted(.dateTime) },
//                                    set: { newString in
//                                        if let newDate = DateFormatter().date(from: newString) {
//                                            nextDaySunrise = newDate
//                                        }
//                                    }
//                                ))
//                            }
//                                .onAppear {
//                                    locationManager.requestLocation()
//                                }
//                            
//                                .frame(width: UIScreen.main.bounds.size.width / 1.125, height: UIScreen.main.bounds.size.height / 2)
//                                .border(Color.black, width: 1)
//                                .foregroundColor(Color.white)
//                            //                        })
//                            //
//                            //
//                            HStack(alignment: .bottom, content: {
//                                List(0..<hours.count, id: \.self) { index in
//                                    let segment = hours[index]
//                                    Text("Hour \(segment.label)\n\(segment.start.formatted(.dateTime))\n\(segment.end.formatted(.dateTime))")
//                                        .padding() // Optional: Add padding for better spacing
//                                        .background(index < 12 ? Color.yellow.opacity(0.3) : Color.blue.opacity(0.3)) // Conditional background
//                                        .cornerRadius(8) // Optional: Rounded corners
//                                }
//                                .background(Color.clear)
//                                .scrollContentBackground(Visibility.hidden)
//                            })
//                            //
//                            //                        .background(Color.clear)
//                            //                        .frame(width: UIScreen.main.bounds.size.width / 3, height: UIScreen.main.bounds.size.height / 2)
//                            //                        .border(Color.black, width: 1)
//                            //                    })
//                            //                }})
//                        })
//                    })
//                })
//            }
//        })
//    }
//}
//
//// MARK: - Location Manager
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var location: CLLocation?
//    private let manager = CLLocationManager()
//    
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//    
//    func requestLocation() {
//        manager.requestWhenInUseAuthorization()
//        manager.requestLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            self.location = location
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to get location: \(error.localizedDescription)")
//    }
//}
//
//// MARK: - Sunrise/Sunset Calculator
//
//class SunriseSunsetCalculator {
//    func calculateSunrise(for date: Date, latitude: Double, longitude: Double) -> Date? {
//        return calculate(for: date, latitude: latitude, longitude: longitude, isSunrise: true)
//    }
//    
//    func calculateSunset(for date: Date, latitude: Double, longitude: Double) -> Date? {
//        return calculate(for: date, latitude: latitude, longitude: longitude, isSunrise: false)
//    }
//    
//    private func calculate(for date: Date, latitude: Double, longitude: Double, isSunrise: Bool) -> Date? {
//        let calendar = Calendar.current
//        let day = calendar.component(.day, from: date)
//        let month = calendar.component(.month, from: date)
//        let year = calendar.component(.year, from: date)
//        
//        // Step 1: Calculate day of the year
//        let N1 = floor(275 * Double(month) / 9)
//        let N2 = floor((Double(month) + 9) / 12)
//        let N3 = (1 + floor((Double(year) - 4 * floor(Double(year) / 4) + 2) / 3))
//        let N = N1 - (N2 * N3) + Double(day) - 30
//        
//        // Step 2: Convert longitude to hour value and calculate approximate time
//        let lngHour = longitude / 15
//        let t = isSunrise ? N + ((6 - lngHour) / 24) : N + ((18 - lngHour) / 24)
//        
//        // Step 3: Calculate Sun's mean anomaly
//        let M = (0.9856 * t) - 3.289
//        
//        // Step 4: Calculate Sun's true longitude
//        var L = M + (1.916 * sin(M * .pi / 180)) + (0.020 * sin(2 * M * .pi / 180)) + 282.634
//        L = fmod(L, 360)
//        
//        // Step 5: Calculate Sun's right ascension
//        var RA = atan(0.91764 * tan(L * .pi / 180)) * 180 / .pi
//        RA = fmod(RA, 360)
//        
//        // Step 5b: Adjust RA to the same quadrant as L
//        let Lquadrant = floor(L / 90) * 90
//        let RAquadrant = floor(RA / 90) * 90
//        RA = RA + (Lquadrant - RAquadrant)
//        
//        // Step 5c: Convert RA to hours
//        RA = RA / 15
//        
//        // Step 6: Calculate Sun's declination
//        let sinDec = 0.39782 * sin(L * .pi / 180)
//        let cosDec = cos(asin(sinDec))
//        
//        // Step 7a: Calculate Sun's local hour angle
//        let cosH = (cos(90.833 * .pi / 180) - (sinDec * sin(latitude * .pi / 180))) / (cosDec * cos(latitude * .pi / 180))
//        guard cosH <= 1, cosH >= -1 else {
//            return nil // Return nil if no sunrise/sunset occurs
//        }
//        
//        // Step 7b: Calculate H
//        var H = isSunrise ? 360 - acos(cosH) * 180 / .pi : acos(cosH) * 180 / .pi
//        H = H / 15
//        
//        // Step 8: Calculate local mean time of rising/setting
//        let T = H + RA - (0.06571 * t) - 6.622
//        
//        // Step 9: Adjust to UTC
//        var UT = T - lngHour
//        UT = UT < 0 ? UT + 24 : UT // Ensure UT is within 0-24 range
//        UT = UT >= 24 ? UT - 24 : UT
//        
//        // Step 10: Convert to local time
//        let localTime = UT + Double(TimeZone.current.secondsFromGMT()) / 3600
//        let localTimeAdjusted = localTime < 0 ? localTime + 24 : localTime // Handle negative times
//        let hour = Int(localTimeAdjusted)
//        let minute = Int((localTimeAdjusted - Double(hour)) * 60)
//        let second = Int((((localTimeAdjusted - Double(hour)) * 60) - Double(minute)) * 60)
//        
//        // Create a Date object for the result
//        var components = calendar.dateComponents([.year, .month, .day], from: date)
//        components.hour = hour % 24
//        components.minute = minute % 60
//        components.second = second % 60 // Add the seconds component
//        
//        let utcDate = calendar.date(from: components)
//        
//        //        let localTimeZone = TimeZone.current
//        //        let secondsFromUTC = localTimeZone.secondsFromGMT(for: utcDate ?? date)
//        //        let localDate = utcDate?.addingTimeInterval(TimeInterval(secondsFromUTC))
//        //
//        return utcDate
//    }
//}
//
//
//#Preview {
//    ContentView()
//}
