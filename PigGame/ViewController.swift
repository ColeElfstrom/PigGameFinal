//
//  ViewController.swift
//  PigGame
//
//  Created by Elfstrom, Cole B on 10/3/19.
//  Copyright © 2019 Elfstrom, Cole B. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var playerNameLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Points needed to win
        let winCondition: Int = 100
        
        //Dice constants
        let player1 = Dice("Player 1") //Name can change in the future with player input
        let player2 = Dice("Player 2") //Name can change in the future with player input
        
        //Player turns
        var playerTemp = player1
            
            playerTemp.roll()
            
            if playerTemp.value == 1
            {
                playerTemp.resetPoints()
            }
            
            rollDice = false
            endTurn = false
            while !endTurn && !rollDice {} //Pause game until endTurnButton or rollDice Button is pressed
        
            if rollDice
            {
                playerTemp.roll()
                
                if playerTemp.value == 1
                {
                    playerTemp.resetPoints()
                    break
                }
            }
                
            else if endTurn
            {
                playerTemp.endTurn()
                break
            }
            
            playerTemp = (playerTemp.name == player1.name) ? player2 : player1
            playerNameLabel.text = "\(playerTemp.name) Turn"
        
    }
}

class Player
{
    var totalPoints: Int
    var turnPoints: Int
    var name: String
    
    init(_ name: String)
    {
        self.totalPoints = Int()
        self.turnPoints = Int()
        self.name = name
    }
    
    func resetPoints()
    {
        turnPoints = 0
    }
    
    func endTurn()
    {
        totalPoints += turnPoints
    }
}

class Dice: Player
{
    var value: Int
    
    override init(_ name: String)
    {
        self.value = Int()
        super.init(name)
    }
    
    func roll()
    {
        value = Int.random(in: 1..<7)
        turnPoints += value
    }
    
    func printRoll()
    {
        print(value)
    }
}
