//
//  CardView.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 25/08/21.
//

import UIKit

protocol CardViewDelegate: AnyObject {
    func tapped(onCardView: CardView, andFinalState: CardView.CardViewState)
}

class CardView: UIView {
    
    enum CardViewState {
        case faceUp
        case faceDown
    }
    
    weak var delegate: CardViewDelegate?
    private var bgColor: UIColor?
    private var state: CardViewState = .faceDown {
        willSet {
            if let faceImageView = self.subviews[0] as? UIImageView {
                faceImageView.isHidden = newValue == .faceDown
            }
            
        }
    }
    
    var faceImage: UIImage?
    
    override func draw(_ rect: CGRect) {
        bgColor?.setFill()
        UIRectFill(rect)
    }
    
    init(frame: CGRect, faceImage: UIImage?, andColor color: UIColor) {
        super.init(frame: frame)
        self.bgColor = color
        self.setNeedsDisplay()
        let faceImageView = UIImageView(image: faceImage)
        faceImageView.contentMode = .scaleAspectFill
        self.addSubview(faceImageView)
        faceImageView.isHidden = self.state == .faceDown
        self.faceImage = faceImage
    }
    
    override func layoutSubviews() {
        // The view will always contain one sub view. So safe to use index 0
        let faceImageView = self.subviews[0]
        
        // Setting the height and width of the image view equal to the view size
        faceImageView.translatesAutoresizingMaskIntoConstraints = false
        faceImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        faceImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        faceImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        faceImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Flip Animation when tapped on the card view and show/hide image
        if self.state == .faceDown {
            self.state = .faceUp
            UIView.transition(with: self, duration: 1.0, options: .transitionFlipFromRight, animations: nil)
        } else {
            self.state = .faceDown
            UIView.transition(with: self, duration: 1.0, options: .transitionFlipFromLeft, animations: nil)
        }
        self.delegate?.tapped(onCardView: self, andFinalState: self.state)
    }
    
}
