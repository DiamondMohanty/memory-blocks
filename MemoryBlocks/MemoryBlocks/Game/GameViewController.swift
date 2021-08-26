//
//  ViewController.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 25/08/21.
//

import UIKit

class GameViewController: UIViewController {

    var images = [String]()
    let theme = (UIApplication.shared.delegate as? AppDelegate)?.theme ?? .normal
    var cardViews = [CardView]()
    
    var tapCounter = 0
    var totalMoves = 0 {
        didSet {
            moveLabel.text = "\(totalMoves)"
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moveLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        switch self.theme {
        case .halloween:
            self.view.backgroundColor = .black
        case .normal:
            self.view.backgroundColor = .white
        }
        self.containerView.backgroundColor = self.view.backgroundColor
        self.initializeGame()
    }
    
    func initializeGame() {
        
        let gridSize = (4,4)
        self.images = FaceImages.getImages(forGridSize: gridSize)
        let spacing: CGFloat = 10.0
        let cardDimension = (self.view.bounds.width / CGFloat(gridSize.0)) - spacing

        // Calculating the new height of the container view
        var currentX: CGFloat = 0.0
        var currentY: CGFloat = (CGFloat(gridSize.1) * cardDimension) + (spacing * CGFloat(gridSize.1))
        
        let newContainerFrame = CGRect(origin: self.containerView.bounds.origin, size: CGSize(width: self.containerView.bounds.width, height: currentY))
        self.containerView.frame = newContainerFrame
        self.containerView.center = self.view.center
        
        currentX = self.containerView.bounds.origin.x
        currentY = self.containerView.bounds.origin.y
        
        // Arrange cards
        let imageList = self.images + self.images
        for image in imageList.shuffled() {
            
            if (currentX + cardDimension) > self.view.bounds.width {
                currentY += cardDimension + spacing
                currentX = self.containerView.bounds.origin.x
            }
            
            let aCardView = CardView(frame: CGRect(x: currentX, y: currentY, width: cardDimension, height: cardDimension), faceImage: CardImage(systemName: image), andColor: self.theme.getColor())
            aCardView.delegate = self
            self.cardViews.append(aCardView)
            self.containerView.addSubview(aCardView)
            currentX += cardDimension + spacing
            
        }
    }
    
}

extension GameViewController: CardViewDelegate {
    func tapped(onCardView: CardView, andFinalState: CardView.CardViewState) {
        tapCounter += 1
        totalMoves += 1
        if tapCounter == 2 {
            
            let upCards = self.cardViews.filter {$0.state == .faceUp}
            if upCards[0].faceImage == upCards[1].faceImage {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    _ = upCards.map({ (card) -> Void in
                        card.state = .gone
                    })
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                _ = self.cardViews.filter { (card) -> Bool in
                    return card.state == .faceUp
                }.map { (card) -> Void in
                    card.state = .faceDown
                }
                self.tapCounter = 0
            }
        }
    }
}

