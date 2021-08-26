//
//  CardImage.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 26/08/21.
//

import UIKit

class CardImage: Comparable {
    static func < (lhs: CardImage, rhs: CardImage) -> Bool {
        return false
    }
    
    static func == (lhs: CardImage, rhs: CardImage) -> Bool {
        return lhs.imageName == rhs.imageName
    }
    

    let image: UIImage?
    private var imageName: String
    init(systemName name: String) {
        image = UIImage(systemName: name)
        imageName = name
    }
    

    
}
