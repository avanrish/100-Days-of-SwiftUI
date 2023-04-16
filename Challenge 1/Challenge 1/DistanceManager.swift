//
//  DistanceManager.swift
//  Challenge 1
//
//  Created by Bartosz Lipiński on 15/04/2023.
//

import Combine

class DistanceManager: ObservableObject {
    @Published var inputDistance = 0.0
    @Published var inputUnit = DistanceUnit.m
    @Published var outputUnit = DistanceUnit.m

    /// Converts to meters
    /// - Parameters:
    ///   - inputDistance: distance value to convert
    /// - Returns: Double converted to meters
    func convertToMeters(inputDistance: Double) -> Double {
        switch inputUnit {
        case .km:
            return inputDistance * 1000
        case .feet:
            return inputDistance / 3.281
        case .yards:
            return inputDistance / 1.094
        case .miles:
            return inputDistance * 1760
        default:
            return inputDistance
        }
    }

    /// Converts distance in meters to specific unit
    /// - Parameters:
    ///   - inputDistance: distance converted to desired unit
    /// - Returns: Double distance converted to desired unit
    func outputDistance(inputDistance: Double) -> Double {
        let convertedInputDistance = convertToMeters(inputDistance: inputDistance)
        
        switch outputUnit {
        case .km:
            return convertedInputDistance / 1000
        case .feet:
            return convertedInputDistance * 3.281
        case .yards:
            return convertedInputDistance * 1.094
        case .miles:
            return convertedInputDistance / 1609
        default:
            return convertedInputDistance
        }
    }
}
