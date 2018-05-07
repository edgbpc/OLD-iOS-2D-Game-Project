///Author: Eric Goodwin
//Class: CS 4220 Intro to iOS Applications
//Summer Semester

import Foundation

enum GameDirection {
    case north, east, west, south
}
struct GameLocation {
    let x: Int
    let y: Int
    let allowedDirections: [GameDirection]
    var event: String?
}



struct GameRow {
    var locations: [GameLocation]
}

class GameModel {
    
    private var gameGrid = [GameRow]()
    
    
    //renamed these variables because i feel that the make more sense as X and Y
    private var currentXIndex = 2          // start at (x: 0, y: 0)
    private var currentYIndex = 2
    
    private let minXYvalue = -2
    private let maxXYvalue = 2
    
    init() {
        self.gameGrid = createGameGrid()
    }
    
    func restart() {
        currentXIndex = 2
        currentYIndex = 2
    }
    

    //split the location return function into two seperate functions that just return either the X or Y location.  My implementation does not need to use the Struct GameLocation for purpose of determining where the player is located
    
    func currentXLocation() -> Int{
        return currentXIndex
    }
    
    func currentYLocation() -> Int{
        return currentYIndex
    }
    

    //function accesses the event on the gameboard
   func accessEvents() -> String?{
        return self.gameGrid[currentXIndex].locations[currentYIndex].event
    }
    
    //function implementation simply adds or substrats from the X and Y locations
    func move(direction: GameDirection) {

        if direction == GameDirection.north {
            currentYIndex = currentYIndex + 1
            
        }
        
        if direction == GameDirection.south{
            currentYIndex = currentYIndex - 1
            
        
        }
        
        if direction == GameDirection.east{
            currentXIndex = currentXIndex + 1
            
        }
        
        if direction == GameDirection.west{
            currentXIndex = currentXIndex - 1
        }
    }

    
    
    // MARK: Helper methods for creating grid
    //made one change to this.  added a control so that a special event could not be loaded into the start location.  this is to prevent it from being triggered when the user resets the location

    private func createGameGrid() -> [GameRow] {
        var gameGrid = [GameRow]()
        
        for yValue in minXYvalue...maxXYvalue {
            var locations = [GameLocation]()
            for xValue in minXYvalue...maxXYvalue {
                let directions = allowedDirectionsForCoordinate(x: xValue, y: yValue)
                let event = eventForCoordinate(x: xValue, y: yValue)
                let location = GameLocation(x: xValue, y: yValue, allowedDirections: directions, event: event)
                locations.append(location)
            }
            let gameRow = GameRow(locations: locations)
            gameGrid.append(gameRow)
        }
        gameGrid[2].locations[2].event = nil //ensures a special event is not loaded in starting location
        return gameGrid
    }
    

    //function unchanged from how provided
    private func allowedDirectionsForCoordinate(x: Int, y: Int) -> [GameDirection] {
        var directions = [GameDirection]()
        
        switch y {
        case minXYvalue:    directions += [.south]
        case maxXYvalue:    directions += [.north]
        default:            directions += [.north, .south]
        }
        
        switch x {
        case minXYvalue:    directions += [.east]
        case maxXYvalue:    directions += [.west]
        default:            directions += [.east, .west]
        }
        
        return directions
    }
    
    /*
        
        function creates an array of possible special events.  as the gameboard is initialized, which event (or no event) is randomly chosen and placed in the grid.  The events remain the same through the instance of that game but each time the App is run, the events and their locations will change.
     
        could have written series of if statements to govern which squares could have a special event, but I think the randomness that all squares MIGHT have an event, and that event is randomly chosen, is more fun for the player
     
     */
    private func eventForCoordinate(x: Int, y: Int) -> String? {
        
    
        let indexNumber = Int(arc4random_uniform(7)) //get a random number to provide as array index.  increase Int passed to the function if additional events are added to the array
        
        var events = [String?]() //empty array allows to easily add more events by appending in the code below
        
        events.append("Lol Ninja CatAttack 😼")
        events.append("Giant PANDA hug 🐼")
        events.append("Super Saiyan 6!\nIts Over 9000!")
        events.append("AW! Dinosaur.  RUN!")
        events.append(nil) //multiple nils to increase chance that no event will be in a loacation
        events.append(nil)
        events.append(nil)
        
        return events[indexNumber]
    }

    
    
}
