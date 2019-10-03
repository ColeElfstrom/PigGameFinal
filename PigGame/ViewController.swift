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
    @IBOutlet var rollDiceLabel: UILabel!
    
    //Game Over Views
    @IBOutlet var gameOverSkyView: UIView!
    @IBOutlet var gameOverGroundView: UIView!
    
    //Game Over Labels
    @IBOutlet var playerWinnerLabel: UILabel!
    @IBOutlet var gameOverP1ScoreLabel: UILabel!
    @IBOutlet var gameOverP2ScoreLabel: UILabel!
    
    //Static Labels
    @IBOutlet var staticP1ScoreLabel: UILabel!
    @IBOutlet var staticP2ScoreLabel: UILabel!
    
    //Actions
    @IBAction func rollDiceAction(_ sender: Any)
    {
        playerTemp.roll()
        //rollDiceLabel.text = "\(playerTemp.value)"
        
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
            
            staticP1ScoreLabel.text = "Player 1 Score"
            staticP2ScoreLabel.text = "Player 2 Score"
            
            gameOverP1ScoreLabel.text = "\(player1.totalPoints)"
            gameOverP2ScoreLabel.text = "\(player2.totalPoints)"
            
            //Display a pig image here
        }
    }
    
    func setPlayerTemp(_ player: Dice)
    {
        self.playerTemp = player
    }
    
    func setLabelsToBlank()
    {
        //Enable or Disable
        rollDiceLabel.text = String()
        
        playerWinnerLabel.text = String()
        staticP1ScoreLabel.text = String()
        staticP2ScoreLabel.text = String()
        gameOverP1ScoreLabel.text = String()
        gameOverP2ScoreLabel.text = String()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        gameOverSkyView.isOpaque = false
        gameOverGroundView.isOpaque = false
        
        setLabelsToBlank()
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
        turnPoints = 0
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
