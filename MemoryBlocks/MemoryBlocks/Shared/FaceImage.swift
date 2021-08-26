//
//  FaceImage.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 26/08/21.
//

import Foundation

class FaceImages {
    
    private static let availableImages = [
        "heart.fill",
        "house.fill",
        "person.fill",
        "airplane",
        "car.fill",
        "moon.fill",
        "mic.fill",
        "gamecontroller.fill"
    ]
    
    static func getImages(forGridSize gridSize: (Int, Int)) -> [String] {
        let totalCells = gridSize.0 * gridSize.1
        let imagesRequired = totalCells/2
        
        let shuffledIndex = Array(0..<imagesRequired).shuffled()
        var returnArray = [String]()
        for index in shuffledIndex {
            returnArray.append(availableImages[index])
        }
        return returnArray
        
    }
}
