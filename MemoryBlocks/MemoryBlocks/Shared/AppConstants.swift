//
//  colorSchemes.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 26/08/21.
//

import UIKit

enum AppTheme {
    case halloween
    case normal

    func getColor() -> UIColor {
        switch self {
        case .halloween:
            return UIColor.orange
        case .normal:
            return UIColor(red: 22/255, green: 156/255, blue: 173/255, alpha: 1.0)
        }
    }
}



