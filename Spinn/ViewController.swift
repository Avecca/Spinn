//
//  ViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-01-17.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class ViewController: StylingViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    let segueId = "segueToSubjectId"
    
    @IBOutlet weak var addPlayerTxtField: UITextField!
    @IBOutlet weak var playerCollectionView: UICollectionView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var playersTitleLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        welcomeLbl.text = NSLocalizedString("welcome_description", comment: "")
        playBtn.setTitle(NSLocalizedString("play_button", comment: ""), for: .normal)
        
        //delegaten för textfielden
        addPlayerTxtField.delegate = self
        addPlayerTxtField.backgroundColor = .white
        addPlayerTxtField.borderStyle = .none
        //addPlayerTxtField.becomeFirstResponder()
        
        //delegate and datasource for the players collection view
        playerCollectionView.delegate = self
        playerCollectionView.dataSource = self
 

        
    }

    
    @IBAction func rdyToiPlatBtn(_ sender: Any) {
        
        performSegue(withIdentifier: segueId, sender: self)
    }
    
    @IBAction func deletePlayerButtonPressed(_ sender: UIButton) {
        //print("Delete btn pressed!!")
        
        let index = sender.tag  //TODO check how to check this in if let
        
        removePlayer(index: index)
        
        //reload the listed view
        self.playerCollectionView.reloadData()
        
        //If empty list remove the ability to press play
        if GamePlay.playerArray.isEmpty {
            //print("array tom efter delete!")
            playBtn.isHidden = true
        }
    }
    
    func removePlayer(index: Int) {
        GamePlay.playerArray.remove(at: index)
    }
    
    
    @IBAction func addPlayer(_ sender: Any) { //pressed
        //super.addPlayer(name: "Hanna")
        //addPlayerTxtField.isEnabled = true
        playersTitleLbl.isHidden = false
        addPlayerTxtField.isHidden = false
        addPlayerTxtField.becomeFirstResponder()
    }
    

    
    //segue to next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //print("Override händer med \(super.players.playerArray.count) players")
        print("Override händer med \(GamePlay.playerArray.count) players")
        
        let destinationVC = segue.destination as! SubjectViewController
        destinationVC.recievingName = nil
    }
    
    //return segue
    @IBAction func unwindToHere(segue: UIStoryboardSegue) {
       // print("Tillbaka till Start")
        self.playerCollectionView.reloadData()
        playBtn.isHidden = true
        
    }
    
    
    //DataSource och delegat for collectionviewn
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return super.players.playerArray.count
        return GamePlay.playerArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayerCollectionViewCell
        let cellIndex = indexPath.item
        
        cell.nameLbl.text = GamePlay.playerArray[cellIndex].getName() //super.players.playerArray[cellIndex].getName()
        
        cell.deleteBtn.isHidden = false
        cell.deleteBtn.tag = cellIndex
        
        
        return cell
    }
    
    
    
    
    
        //delegat func för addPlayerTxtField
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addPlayerTxtField.borderStyle = .bezel
    }
    
  
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 10
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //addPlayerTxtField.backgroundColor = super.bgColor
        //addPlayerTxtField.isEnabled = false
        addPlayerTxtField.isHidden = true
        if !GamePlay.playerArray.isEmpty {
           // print("INte tom!")
            playBtn.isHidden = false
        }
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if addPlayerTxtField.isFirstResponder {
            //super.players.addPlayer(name: addPlayerTxtField.text!)
                    if( !GamePlay.playerArray.contains(where: { $0.getName()  == addPlayerTxtField.text!})) {
                        //print("Adding player with name \(addPlayerTxtField.text)")
                       
                        addPlayer()
                        
                    } else {
                        //TODO POPUP KANSSKE?
                    }
            
            //GamePlay.playerArray.append(Player(addPlayerTxtField.text!))
            addPlayerTxtField.resignFirstResponder()
            addPlayerTxtField.text = nil
            addPlayerTxtField.backgroundColor = .white
            
            self.playerCollectionView.reloadData()
            
        }
        return true
    }
    
    func addPlayer() {
        
        if let player = addPlayerTxtField.text {
            GamePlay.playerArray.append(Player(player))
        }
        
    }
    
    
}



//    func deletePlayer(index: Int) {
//        //super.removePlayer(index: index)
//        super.players.removePlayer(index: index)
//
//    }
