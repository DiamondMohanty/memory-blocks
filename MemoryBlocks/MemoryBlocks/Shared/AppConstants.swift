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
            return UIColor.white
        }
    }
}


