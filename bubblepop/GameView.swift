import UIKit

class GameView: UIViewController {
    

    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var pointsCount: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var segue: UIButton!
    @IBOutlet weak var otherSegue: UIButton!

    @IBOutlet weak var black: BubbleButton!
    @IBOutlet weak var blue: BubbleButton!
    @IBOutlet weak var green: BubbleButton!
    @IBOutlet weak var pink: BubbleButton!
    @IBOutlet weak var red: BubbleButton!

    @IBOutlet weak var gameArea: UIView!
    
    var bubbleCount = 0
    var bubbleCounter = 0
    
    var score = Int()
    var spawnRate = Int()
    var rate = Int()
    var colourNum = Int()
    var nameVar = ""
    
    var currentBubble = BubbleButton()
    var previousBubble = BubbleButton()
    
    var times = Int()
    var bubblePoints = Array<BubbleButton>()
    var highScoresArray = Array<HighScore>()
    var highestScore = 0
    
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        bubbleCount = 0
        bubbleCounter = 0
        //Initialise points for each bubble
        red.points = 1
        pink.points = 2
        green.points = 5
        blue.points = 8
        black.points = 10
        //Clears the view
        self.bubblePoints = [red, pink, green, blue, black]
        clearScreen()
        segue.isEnabled = false
        otherSegue.isEnabled = false
        //Setting up the score and timer
        score = 0
        timeCount.text = String(times)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        //Setting up High Scores
        highestScore = findHighestScore(array: highScoresArray)
        highScore.text = String(highestScore)
    }
    
    @objc func tick() {
        if (times == 0) {
            timer.invalidate()
            //Checks and Adds HighScores
            var present = false
            var higherScore = false
            for item in highScoresArray {
                if (nameVar.lowercased()==item.name.lowercased() && score>=item.highScore) {
                    let oldIndex = findOldEntry(player: nameVar, array: highScoresArray)
                    highScoresArray.remove(at: oldIndex)
                    present = true
                    higherScore = true
                } else if (nameVar.lowercased()==item.name.lowercased() && score<item.highScore) {
                    present = true
                    higherScore = false
                }
            }
            if (higherScore==true || present == false){
                let newPlayer = HighScore()
                newPlayer.name = nameVar
                newPlayer.highScore = score
                let newIndex = findPlaceInArray(array: highScoresArray)
                highScoresArray.insert(newPlayer, at: newIndex)
            }
            let alert = UIAlertController(title: "Game Over", message: "Congrats! Your score was \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"High Scores", style: .default, handler: {
                action in
                self.performSegue(withIdentifier: "highScoreSegue", sender: self)
            }))
            alert.addAction(UIAlertAction(title:"Home", style:.cancel,handler:{
                action in
                self.performSegue(withIdentifier: "homeSegue", sender: self)
            }))
            self.present(alert, animated: true)
            
        } else {
            clearScreen()
            times -= 1
            timeCount.text = String(times)
            
            rate = Int(arc4random())%self.spawnRate + 1
            var count = 0
            while (rate > count) {
                count += 1
                colourNum = Int(arc4random())%100 + 1
                let add = addBubbles()
                if (add != nil) {
                    self.gameArea.addSubview(add!)
                }
            }
        }
    }
    
    func addBubbles() -> BubbleButton? {
        currentBubble = colourChoice(bubble: currentBubble)
        let bubble = currentBubble
        bubble.addTarget(self, action: #selector(pressingBubble(_:)), for: UIControlEvents.touchUpInside)
        let xx: Int = (Int(40 + arc4random_uniform(UInt32(self.gameArea.frame.size.width - 80))))
        let yy: Int = (Int(40 + arc4random_uniform(UInt32(self.gameArea.frame.size.height - 80))))
        let c = CGPoint(x: xx, y: yy)
        bubble.center = c
        for others in gameArea.subviews {
            if (bubble.frame.intersects(others.frame)) {
                return nil
            }
        }
        return bubble
    }
    
    func colourChoice(bubble: BubbleButton) -> BubbleButton {
        switch colourNum {
        case 0...40:
            return bubblePoints[0]
        case 41...70:
            return bubblePoints[1]
        case 71...85:
            return bubblePoints[2]
        case 86...95:
            return bubblePoints[3]
        default:
            return bubblePoints[4]
        }
    }
    
    @IBAction func pressingBubble(_ sender: BubbleButton) {
        var points = Int()
        if (sender == previousBubble) {
            points = Int(Double(sender.points) * 1.5)
        } else {
            points = sender.points
        }
        score += points
        pointsCount.text = String(score)
        
        sender.removeFromSuperview()
        bubbleCount -= 1
        previousBubble = sender
        
        if (score > highestScore) {
            highScore.text = String(score)
        }
    }
    
    func clearScreen() {
        for bubble in bubblePoints {
            bubble.removeFromSuperview()
        }
    }
    
    func findHighestScore(array: Array<HighScore>) -> Int {
        var max = 0
        if (array.count == 1) {
            max = array[0].highScore
        } else if (array.count >= 2) {
            for i in (0..<array.count) {
                if (array[i].highScore > max) {
                    max = array[i].highScore
                }
            }
        }
        return max
    }
    
    func findPlaceInArray(array: Array<HighScore>) -> Int {
        var index = 0
        while score<array[index].highScore {
            index += 1
        }
        return index
    }
    
    func findOldEntry(player: String, array: Array<HighScore>) -> Int {
        var place = Int()
        for index in 0..<array.count {
            if (array[index].name == nameVar) {
                place = index
            }
        }
        return place
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendHSArray = highScoresArray
        if (segue.identifier == "homeSegue") {
            if let viewController = segue.destination as? HomeView {
                viewController.highScoreArray = sendHSArray
            }
        }
        if (segue.identifier == "highScoreSegue") {
            if let viewController = segue.destination as? HighScoresView {
                viewController.highScoreArray = sendHSArray
            }
        }
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
