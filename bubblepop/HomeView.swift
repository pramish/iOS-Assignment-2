import UIKit

class HomeView: UIViewController {
    
    var highScoreArray = Array<HighScore>()
    
    

    @IBOutlet weak var nameText: UITextField!
    
    @IBAction func playBttn(_ sender: Any) {
        performSegue(withIdentifier: "gameSegue", sender: nil)
    }
    @IBOutlet weak var playButton: UIButton!
    @IBAction func highScoreBttn(_ sender: Any) {
    }
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var bubsLbl: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var bubsSlider: UISlider!
    @IBAction func amountSliderChange(_ sender: UISlider) {
        let value = Int(sender.value)
        bubsLbl.text = "\(value)"
    }
    @IBAction func durationSliderChange(_ sender: UISlider) {
        let value = Int(sender.value)
        durationLbl.text = "\(value)"
    }

    @IBAction func txtChange(_ sender: Any) {
        if nameText.text == "" {
            playButton.isEnabled = true
        } else if nameText.text != "" {
            playButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playButton.isEnabled = true
        if (highScoreArray.isEmpty == true) {
            let firstScore=HighScore()
            firstScore.name = ""
            firstScore.highScore = 0
            highScoreArray.append(firstScore)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let intToSend = Int(durationSlider.value)
        let spawnSent = Int(bubsSlider.value)
        let nameSend = nameText.text
        let hsSend = highScoreArray
        
        if segue.identifier == "gameSegue" {
            if let viewController = segue.destination as? GameView {
                viewController.times = intToSend
                viewController.spawnRate = spawnSent
                viewController.nameVar = nameSend!
                viewController.highScoresArray = hsSend
            }
        }
        
        if segue.identifier == "highSegue" {
            if let viewController = segue.destination as? HighScoresView {
                viewController.highScoreArray = hsSend
            }
        }
    }
}
