//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TweetSentimentClassifier()

    let tweetCount = 100
    
  let swifter = Swifter(consumerKey: "sxsQBGMTC1gYbCsmfpc1l0KHx", consumerSecret: "7hvNIQ3gsniE0LU2NxKBjy3AWfPh2yVyKyZKRIcITQQRW6GIpF")
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func predictPressed(_ sender: Any) {

            fetchTweet()
    }
    
    func fetchTweet(){
        
            if let searchText = textField.text{
                
                swifter.searchTweet(using: searchText,lang: "en", count: tweetCount, tweetMode: .extended){ (results, metadata) in
                  
                    var tweets = [TweetSentimentClassifierInput]()
                    
                    for i in 0..<self.tweetCount{
                        if let tweet = results[i]["full_text"].string{
                            
                            let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                            
                            tweets.append(tweetForClassification)
                        }
                    }
            
                    self.makePrediction(with: tweets)
                    
                } failure: { (error) in
                    print("There was the error with twitter API request,\(error)")
                }
                
               
            }
    }
    func makePrediction(with tweets:[TweetSentimentClassifierInput]){
        do {
            
           let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
           // print(predictions[0].label)
            var sentimentScore = 0
            
            for prediction in predictions{
                let sentiment = prediction.label
                
                if sentiment == "Pos"{
                    sentimentScore += 1
                }else if sentiment == "Neg"{
                    sentimentScore -= 1
                }
            }
            
            updateUI(with: sentimentScore)
            
            }catch{
            print("There was an error predicting tweets,\(error)")
        }
    }
    func updateUI(with sentimentScore: Int){
        
        if sentimentScore > 30 {
            self.sentimentLabel.text = "😍"
        }else if sentimentScore > 20{
            self.sentimentLabel.text = "🥰"
        }else if sentimentScore > 10{
            self.sentimentLabel.text = "😀"
        }else if sentimentScore > 0{
            self.sentimentLabel.text = "🙂"
        }else if sentimentScore == 0{
            self.sentimentLabel.text = "😐"
        }else if sentimentScore > -10{
            self.sentimentLabel.text = "😕"
        }else if sentimentScore > -20{
            self.sentimentLabel.text = "🤬"
        }else if sentimentScore > -30{
            self.sentimentLabel.text = "🤢"
        }else{
            self.sentimentLabel.text = "🤮"
        }
        
    }
}

