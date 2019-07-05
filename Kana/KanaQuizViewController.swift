//
//  ViewController.swift
//  Kana
//
//  Created by Arda Satata on 02/07/19.
//  Copyright © 2019 Arda Satata. All rights reserved.
//

import UIKit
import SwiftyJSON

class KanaQuizViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var KanaText: UILabel!
    @IBOutlet weak var KanaRomaji: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessAnswerResult: UILabel!
    @IBOutlet weak var kanaAnswerChar: UILabel!
    
    
    var characterPool: [Character] = [] //character yang dimasukkan quiz
    var usedCharacterId: [Int] = [] //id Character yg sudah ditebak
    
    var currentCharacter: Character = Character()
    var correctAnswer: Character = Character()
    
    //var characterType: String = "" //hiragana,katakana,all
    
    @IBAction func submitPressed(_ sender: UIButton) {
            handleSubmit()
    }
    
    func handleSubmit(){
        guessTextField.delegate = self
        handleGuess()
        guessTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadCharacter()
        showNewCharacter()
        updateCharacter()
    }
    
    func showNewCharacter(){

        currentCharacter = characterPool[0]
        
        if ((usedCharacterId.count - characterPool.count) >= 0 ) {
            //quiz selesai
            print("sisa 1")
        }else{
            while (usedCharacterId.contains(currentCharacter.id)) {
                currentCharacter = characterPool[Int.random(in: 0 ..< characterPool.count)]
            }
        }
        
        print(usedCharacterId.count)
        print(currentCharacter.id)
        print(currentCharacter.char)

    }
    
    func checkGuess(guess: String) -> Bool{
        for romaji in currentCharacter.romaji {
            if (guess.lowercased()==romaji){
                return true
            }
        }
        return false
    }
    
    func handleGuess(){
        let guess = guessTextField.text!
        
        if checkGuess(guess: guess) {
            guessAnswerResult.text = Constants.correctAnswerType
            correctAnswer = currentCharacter
            showNewCharacter()
            updateCharacter()
            updateAnswerStatus()
            usedCharacterId.append(currentCharacter.id)
        }
        else{
            guessAnswerResult.text = Constants.wrongAnswerType
            kanaAnswerChar.isHidden = true
            KanaRomaji.isHidden = true
        }
    }
    
    func updateCharacter(){
        KanaText.text = currentCharacter.char
    }
    
    func updateAnswerStatus(){
        KanaRomaji.isHidden = false
        KanaRomaji.text = correctAnswer.romaji.joined(separator: ", ")
        kanaAnswerChar.isHidden = false
        kanaAnswerChar.text = correctAnswer.char
    }

    func loadCharacter(){
        
        if let path = Bundle.main.path(forResource: "char_test", ofType: "json") {
            
            var indexId: Int = 0
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                //print(jsonObj)
                //print(jsonObj["hiragana"][0]["romaji"])
                
//                for type in jsonObj{
//                    print(type)
//                    print("hehe")
//                }
                
                for (index,subJson):(String, JSON) in jsonObj {
                    print(index)
                    for (index,subJson):(String, JSON) in subJson {

                        
                        var romajiArray: [String] = []
                        
                        for romaji in subJson["romaji"]{
                            //characterPool.append(Character.init(id: 1, type: index, char: subJson["char"].string ?? "", romaji: romaji))
                            romajiArray.append(romaji.1.string ?? "")
                            print(romaji.1)
                        }
                        
                        indexId+=1
                        print(indexId)
                        print(subJson["char"])
                        
                        characterPool.append(Character.init(id: indexId, type: index, char: subJson["char"].string ?? "", romaji: romajiArray))
                        
                        //print(romajiArray)
                    }
                    //print(subJson)
                }
                
                print(characterPool.count)
                //characterPool.removeAll()
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guessTextField.becomeFirstResponder()
        handleSubmit()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 3
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
}

