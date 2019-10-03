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
    //Instance Variables
    let winCondition: Int = 100
    var winner: Bool = false
    
    var playerTemp: Dice = Dice("temp")
    let player1 = Dice("Player 1") //Name can change in the future with player input
    let player2 = Dice("Player 2") //Name can change in the future with player input
    
    //Current Game Labels
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var playerTotalScoreLabel: UILabel!
    @IBOutlet var playerTurnScoreLabel: UILabel!
    
    //Game Over Labels
    @IBOutlet var gameOverSkyView: UIView!
    @IBOutlet var gameOverGroundView: UIView!
    @IBOutlet var playerWinnerLabel: UILabel!
    @IBOutlet var gameOverP1ScoreLabel: UILabel!
    @IBOutlet var gameOverP2ScoreLabel: UILabel!
    
    //Actions
    @IBAction func rollDiceAction(_ sender: Any)
    {
        playerTemp.roll()
        
        if playerTemp.value == 1
        {
            playerTemp.resetPoints()
            playerTemp.endTurn()
            
            playerTemp = (playerTemp.name == player1.name) ? player2 : player1
            playerNameLabel.text = "\(playerTemp.name) Turn"
        }
        
        else
        {
            playerTemp.turnPoints += playerTemp.value
        }
        
        //Display a dice image here
        
        update()
    }
    
    @IBAction func endTurnAction(_ sender: Any)
    {
        playerTemp.endTurn()
        
        if(playerTemp.totalPoints >= winCondition)
        {
            winner = true
        }
        
        else
        {
            playerTemp = (playerTemp.name == player1.name) ? player2 : player1
        }
        
        update()
    }
    
    func update()
    {
        playerNameLabel.text = "\(playerTemp.name) Turn"
        playerTotalScoreLabel.text = "Total Score: \(playerTemp.totalPoints)"
        playerTurnScoreLabel.text = "Turn Score : \(playerTemp.turnPoints)"
        
        if winner
        {
            gameOverSkyView.isOpaque = true
            gameOverGroundView.isOpaque = true
            playerWinnerLabel.text = "\(playerTemp.name) has won!"
            
            gameOverP1ScoreLabel.text = "\(player1.totalPoints)"
            gameOverP2ScoreLabel.text = "\(player2.totalPoints)"
            
            //Display a pig image here
        }
    }
    
    func setPlayerTemp(_ player: Dice)
    {
        self.playerTemp = player
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        gameOverSkyView.isOpaque = false
        gameOverGroundView.isOpaque = false
        
        setPlayerTemp(player1)
        update()
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
    }
    
    func printRoll()
    {
        print(value)
    }
}
