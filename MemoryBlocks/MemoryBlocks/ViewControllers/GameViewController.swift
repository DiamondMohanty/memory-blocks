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
    var timer: Timer?
    var timeElapsed = 0
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.backgroundColor = self.view.backgroundColor
        self.initializeGame()
    }
    
    func initializeGame() {
        
        self.timerLabel.text = "00"
        self.moveLabel.text = "00"
        self.timeElapsed = 0
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [unowned self] (timer) in
            self.timeElapsed += 1
            self.timerLabel.text = "\(self.timeElapsed) s"
        })
        
        let gridSize = (4,4)
        self.images = FaceImages.getImages(forGridSize: gridSize)
        let spacing: CGFloat = 10.0
        let cardDimension = (self.view.bounds.width / CGFloat(gridSize.0)) - spacing

        // Calculating the new height of the container view
        var currentX: CGFloat = 0.0
        var currentY: CGFloat = (CGFloat(gridSize.1) * cardDimension) + (spacing * CGFloat(gridSize.1))
        
        let newContainerFrame = CGRect(origin: CGPoint(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y), size: CGSize(width: self.view.bounds.width - 5, height: currentY))
        self.containerView.frame = newContainerFrame
        self.containerView.center = self.view.center
        
        currentX = self.containerView.bounds.origin.x
        currentY = self.containerView.bounds.origin.y
        
        let cardTintColor: UIColor = self.theme == .halloween ? .systemBlue : .white
        
        // Arrange cards
        let imageList = self.images + self.images
        for image in imageList.shuffled() {
            
            if (currentX + cardDimension) > self.view.bounds.width {
                currentY += cardDimension + spacing
                currentX = self.containerView.bounds.origin.x
            }
            
            let aCardView = CardView(frame: CGRect(x: currentX, y: currentY, width: cardDimension, height: cardDimension), faceImage: CardImage(systemName: image), color: self.theme.getColor(), andTintColor: cardTintColor)
            aCardView.delegate = self
            self.cardViews.append(aCardView)
            self.containerView.addSubview(aCardView)
            currentX += cardDimension + spacing
            
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        
        self.cardViews.removeAll()
        for view in self.containerView.subviews {
            view.removeFromSuperview()
        }
        self.initializeGame()
        
    }
    
    func getFinalScore() -> Int {
        var score: Double = 100
        score = score - ((Double(self.timeElapsed) * 0.1) + Double(self.totalMoves) * 0.5)
        return Int(score)
    }
    
    
    
    deinit {
        self.timer?.invalidate()
    }
    
}

extension GameViewController: CardViewDelegate {
    func tapped(onCardView: CardView, andFinalState: CardView.CardViewState) {
            
        tapCounter += 1
        totalMoves += 1
        if tapCounter == 2 {
            
            let upCards = self.cardViews.filter {$0.state == .faceUp}
            
            guard upCards.count == 2 else {
                return
            }
            
            if upCards[0].faceImage == upCards[1].faceImage {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    _ = upCards.map({ (card) -> Void in
                        card.state = .gone
                    })
                    
                    let remainingCards = self.cardViews.filter { (card) -> Bool in
                        return card.state == .gone
                    }
                    
                    if remainingCards.count == self.cardViews.count {
                        let alert = UIAlertController(title: "Wahooo!!!", message: "Your Score is \(self.getFinalScore())", preferredStyle: .alert)
                        let newGameAction = UIAlertAction(title: "Play Again", style: .default) { [unowned self] (action) in
                            self.newGame(self.newGameButton)
                        }
                        
                        let mainMenuAction = UIAlertAction(title: "Main Menu", style: .default) { [unowned self] (action) in
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                        alert.addAction(newGameAction)
                        alert.addAction(mainMenuAction)
                        self.present(alert, animated: true, completion: nil)
                    }
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

