///Author: Eric Goodwin
//Class: CS 4220 Intro to iOS Applications
//Summer Semester


import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var gameBoard = GameModel()
    let stickFigure = UIImage(named: "clipart-man-stick-man-clip-art_411431.jpg")
    var player: AVAudioPlayer?

    @IBOutlet weak var moveOutput: UILabel!
    @IBOutlet weak var randomEventOutput: UILabel!
    @IBOutlet weak var locationOutput: UILabel!
    
    
    
    @IBOutlet weak var southButton: UIButton!
    @IBOutlet weak var northButton: UIButton!
    @IBOutlet weak var westButton: UIButton!
    @IBOutlet weak var eastButton: UIButton!
    
    
    //this outlets are used to display the stickFigure as it moves around the board
    @IBOutlet weak var positionOne: UIImageView!
    @IBOutlet weak var positionTwo: UIImageView!
    @IBOutlet weak var positionThree: UIImageView!
    @IBOutlet weak var positionFour: UIImageView!
    @IBOutlet weak var positionFive: UIImageView!
    @IBOutlet weak var positionSix: UIImageView!
    @IBOutlet weak var positionSeven: UIImageView!
    @IBOutlet weak var positionEight: UIImageView!
    @IBOutlet weak var positionNine: UIImageView!
    @IBOutlet weak var positionTen: UIImageView!
    @IBOutlet weak var positionEleven: UIImageView!
    @IBOutlet weak var positionTwelve: UIImageView!
    @IBOutlet weak var positionThirteen: UIImageView!
    @IBOutlet weak var positionFourteen: UIImageView!
    @IBOutlet weak var positionFifteen: UIImageView!
    @IBOutlet weak var positionSixteen: UIImageView!
    @IBOutlet weak var positionSeventeen: UIImageView!
    @IBOutlet weak var positionEightteen: UIImageView!
    @IBOutlet weak var positionNineteen: UIImageView!
    @IBOutlet weak var positionTwenty: UIImageView!
    @IBOutlet weak var positionTwentyOne: UIImageView!
    @IBOutlet weak var positionTwentyTwo: UIImageView!
    @IBOutlet weak var positionTwentyThree: UIImageView!
    @IBOutlet weak var positionTwentyFour: UIImageView!
    @IBOutlet weak var positionTwentyFive: UIImageView!
    
    //this outlet will change when the panda event is triggered
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //this outlet will change when the dinosaur event is triggered
    @IBOutlet weak var overviewImage: UIImageView!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocationDisplay() //initially player starts at 0,0
        positionThirteen.image = stickFigure //sets the image to be used on the grid to represent the player moving along the gameBoard
        
        
        //initially loads with no text in the moveOutput label and no background image
        moveOutput.text = ""
        backgroundImage.image = UIImage(named: "")
        
    }
    
    
   /*these move functions update the X and Y values to represent the player as it moves around the gameboard.  also updates the ouput of the gameboard via the updateGameBoard function.  Changes the moveOutput label to show what direction the player has moved.
    */
    @IBAction func moveNorth(_ sender: UIButton) {
        gameBoard.move(direction: .north)
        updateGameBoard()
        moveOutput.text = "Moved North!"
    }
    
    @IBAction func moveWest(_ sender: UIButton) {
        gameBoard.move(direction: .west)
        updateGameBoard()
        moveOutput.text = "Moved West!"
    }
    
    
    @IBAction func moveEast(_ sender: UIButton) {
        gameBoard.move(direction: .east)
        updateGameBoard()
        moveOutput.text = "Moved East!"
    }
    
    @IBAction func moveSouth(_ sender: UIButton) {
        gameBoard.move(direction: .south)
        updateGameBoard()
        moveOutput.text = "Moved South!"
    }
    
    @IBAction func resetBoard(_ sender: UIButton) {
        
        gameBoard.restart()
        moveOutput.text = ""
        randomEventOutput.text = ""
        
        updateGameBoard()
  

    }
    
    //regenerates the board so events location and quantity is changed
    @IBAction func newGameButton(_ sender: UIButton) {
        let newGameBoard = GameModel()
        gameBoard = newGameBoard
        gameBoard.restart()
        moveOutput.text = ""
        randomEventOutput.text = ""
        
        updateGameBoard()
        
    }
  //ADDTIONAL ADDED FUNCTIONS
   
    
  //this function uses several other functions in order to update the gameboard.  description of what each function provided in comments before each function defination.
    func updateGameBoard(){
        self.view.backgroundColor = UIColor(white: 1, alpha: 1) //change background to white
        updateLocationDisplay()
        moveFigure()
        checkLimits()
        randomEventOutput.text = gameBoard.accessEvents() //access the speical event if there is one in a particular point on the grid
        changeBackgroundForPandaEvent()
        changeForegroundImageforDinoEvent()
 
    }
    
    //this function gets the current X, Y value after the player has moved.  the "-2" converts array indexing to a X,Y grid.  IE -2,-2 on X,Y grid = 0,0 in array indexing
    
    
    func locationBuilder() ->String{
        let xCoord = String(gameBoard.currentXLocation() - 2)
        let yCoord = String(gameBoard.currentYLocation() - 2)
        
        let displayText = ("(x: " + xCoord + ", y: " + yCoord + ")")
        
        return displayText
    }
    
    //updates the location label and shows location in a X,Y grid format
    func updateLocationDisplay() {
            self.locationOutput.text = locationBuilder()
    }

    //determines if the player is on the edge of the grid and disables to prevent moving off the grid
    func checkLimits() {
        let xCoord = (gameBoard.currentXLocation() - 2)
        let yCoord = (gameBoard.currentYLocation() - 2)
        
        if yCoord == 2 {
            northButton.isEnabled = false
        } else {
            northButton.isEnabled = true
        }
        
        if yCoord == -2 {
            southButton.isEnabled = false
        } else {
            southButton.isEnabled = true
        }
        
        if xCoord == 2 {
            eastButton.isEnabled = false
        } else {
            eastButton.isEnabled = true
        }
        
        if xCoord == -2 {
            westButton.isEnabled = false
        } else {
            westButton.isEnabled = true
        }
        
        
    }
    
    //determines which UIView to display the stickFigure image based on player movement.  Because each valid location on the grid is seperate UIView, requires a seperate line of code for each possible location.
    
    func moveFigure(){
        let xCoord = (gameBoard.currentXLocation() - 2)
        let yCoord = (gameBoard.currentYLocation() - 2)
        
        clearBoard() //clears all stickFigures from board before drawning new figure
        
        if xCoord == 0 {
           if yCoord == 0 {
                positionThirteen.image = stickFigure
            }
            
            if yCoord == 1 {
                positionEight.image = stickFigure
            }
            
            if yCoord == 2 {
                positionThree.image = stickFigure
            }
            
            if yCoord == -1 {
                positionEightteen.image = stickFigure
            }
            
            if yCoord == -2 {
                positionTwentyThree.image = stickFigure
            }
        }
        
        if xCoord == 1 {
            if yCoord == 0 {
                positionFourteen.image = stickFigure
            }
            
            if yCoord == 1 {
                positionNine.image = stickFigure
            }
            
            if yCoord == 2 {
                positionFour.image = stickFigure
            }
            
            if yCoord == -1 {
                positionNineteen.image = stickFigure
            }
            
            if yCoord == -2 {
                positionTwentyFour.image = stickFigure
            }
        }
        
        if xCoord == 2 {
            if yCoord == 0 {
                positionFifteen.image = stickFigure
            }
            
            if yCoord == 1 {
                positionTen.image = stickFigure
            }
            
            if yCoord == 2 {
                positionFive.image = stickFigure
            }
            
            if yCoord == -1 {
                 positionTwenty.image = stickFigure
            }
            
            if yCoord == -2 {
                positionTwentyFive.image = stickFigure
            }
        }
        
        if xCoord == -1 {
            if yCoord == 0 {
                positionTwelve.image = stickFigure
            }
            
            if yCoord == 1 {
                positionSeven.image = stickFigure
            }
            
            if yCoord == 2 {
                positionTwo.image = stickFigure
            }
            
            if yCoord == -1 {
                positionSeventeen.image = stickFigure
            }
            
            if yCoord == -2 {
                positionTwentyTwo.image = stickFigure
            }
        }
        
        if xCoord == -2 {
            if yCoord == 0 {
                positionEleven.image = stickFigure
            }
            
            if yCoord == 1 {
                positionSix.image = stickFigure
            }
            
            if yCoord == 2 {
                positionOne.image = stickFigure
            }
            
            if yCoord == -1 {
                positionSixteen.image = stickFigure
            }
            
            if yCoord == -2 {
                positionTwentyOne.image = stickFigure
            }
        }
    }
    //function clears the board of the stickFigure image.  always occurs right before a new stickFigure is drawn to give illusion that the figure is "moving" to the new location
    func clearBoard(){
        
        positionOne.image = UIImage(named: "")
        positionTwo.image = UIImage(named: "")
        positionThree.image = UIImage(named: "")
        positionFour.image = UIImage(named: "")
        positionFive.image = UIImage(named: "")
        positionSix.image = UIImage(named: "")
        positionSeven.image = UIImage(named: "")
        positionEight.image = UIImage(named: "")
        positionNine.image = UIImage(named: "")
        positionTen.image = UIImage(named: "")
        positionEleven.image = UIImage(named: "")
        positionTwelve.image = UIImage(named: "")
        positionThirteen.image = UIImage(named: "")
        positionFourteen.image = UIImage(named: "")
        positionFifteen.image = UIImage(named: "")
        positionSixteen.image = UIImage(named: "")
        positionSeventeen.image = UIImage(named: "")
        positionEightteen.image = UIImage(named: "")
        positionNineteen.image = UIImage(named: "")
        positionTwenty.image = UIImage(named: "")
        positionTwentyOne.image = UIImage(named: "")
        positionTwentyTwo.image = UIImage(named: "")
        positionTwentyThree.image = UIImage(named: "")
        positionTwentyFour.image = UIImage(named: "")
        positionTwentyFive.image = UIImage(named: "")
        
        backgroundImage.image = UIImage(named:"")
        overviewImage.image = UIImage(named:"")
        
    }
    
    //function changes the background image if the Panda event is triggered/Users/ericgoodwin/Desktop/your-user-id-here/TwoDimensionalGame/clipart-man-stick-man-clip-art_411431.jpg
    func changeBackgroundForPandaEvent(){
        if gameBoard.accessEvents() == "Giant PANDA hug 🐼" {
            backgroundImage.image = UIImage(named: "panda_hug_time_by_kaorinchan.jpg")
        }
    }
    
    
    
    
    //this code was found on stack overflow and used as found.
    //https://stackoverflow.com/questions/32036146/how-to-play-a-sound-in-swift-2-and-3
    
    
    func playSound() {
         let url = Bundle.main.url(forResource: "dinorun", withExtension: "mp3")
    
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url!)
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    //there is an UIView frame on top of the game board.  this function changes the image to the dinosau otherwise there is no image.  when the player moves off the dinosaur square, the clearboard function removes the image
    
    func changeForegroundImageforDinoEvent(){
        if gameBoard.accessEvents() == "AW! Dinosaur.  RUN!" {
            overviewImage.image = UIImage(named: "cartoon dinosaur 30.png")
            
            playSound()
        }
    }

}


