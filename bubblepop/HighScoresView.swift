import UIKit
class HighScoresView: UIViewController {
    var highScoreArray = Array<HighScore>()
    @IBOutlet weak var firstLast: UILabel!
    @IBOutlet weak var thousand: UILabel!
    var nameXCoord = 100.5
    var scoreXCoord = 285.5
    var yCoord = 123.5
    override func viewDidLoad() {
        super.viewDidLoad()
        let userNameLabel = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 21))
        userNameLabel.center = CGPoint(x: nameXCoord, y: yCoord)
        userNameLabel.text = "Name:"
        userNameLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(userNameLabel)
        
        let scoreTitleLabel = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 21))
        scoreTitleLabel.center = CGPoint(x: scoreXCoord, y: yCoord)
        scoreTitleLabel.text = "Score:"
        scoreTitleLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(scoreTitleLabel)
        yCoord += 30
        // Do any additional setup after loading the view.
        if highScoreArray.count <= 11 {
            for index in 0..<highScoreArray.count-1 {
                
                let nameLabel = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 21))
                nameLabel.center = CGPoint(x: nameXCoord, y: yCoord)
                nameLabel.text = highScoreArray[index].name
                nameLabel.textAlignment = NSTextAlignment.center
                self.view.addSubview(nameLabel)
                
                let scorelabel = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 21))
                scorelabel.center = CGPoint(x: scoreXCoord, y: yCoord)
                scorelabel.text = String(highScoreArray[index].highScore)
                scorelabel.textAlignment = NSTextAlignment.center
                self.view.addSubview(scorelabel)
                
                yCoord += 30
            }
        } else {
            for index in 0...9 {
                let nameLabel = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 21))
                nameLabel.center = CGPoint(x: nameXCoord, y: yCoord)
                nameLabel.text = highScoreArray[index].name
                nameLabel.textAlignment = NSTextAlignment.center
                self.view.addSubview(nameLabel)
                let scorelabel = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 21))
                scorelabel.center = CGPoint(x: scoreXCoord, y: yCoord)
                scorelabel.text = String(highScoreArray[index].highScore)
                scorelabel.textAlignment = NSTextAlignment.center
                self.view.addSubview(scorelabel)
                yCoord += 30
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let hsSend = highScoreArray
        
        if segue.identifier == "backSegue" {
            if let viewController = segue.destination as? HomeView {
                viewController.highScoreArray = hsSend
            }
        }
    }
}
