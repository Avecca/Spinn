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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegaten för textfielden
        addPlayerTxtField.delegate = self
        addPlayerTxtField.backgroundColor = .white
        addPlayerTxtField.borderStyle = .none
        //addPlayerTxtField.becomeFirstResponder()
        
        playerCollectionView.delegate = self
        playerCollectionView.dataSource = self
        
        
        
    }

    
    @IBAction func rdyToiPlatBtn(_ sender: Any) {
        
        performSegue(withIdentifier: segueId, sender: self)
    }
    
    @IBAction func deletePlayerButtonPressed(_ sender: UIButton) {
        
        
        print("Delete btn pressed!!")
        
        let index = sender.tag  //TODO check how to check this in if let
        
        print(index)
        if (super.removePlayer(index: index)) {
            self.playerCollectionView.reloadData()
            
        }
       
        
        
    }
    
    
    @IBAction func addPlayer(_ sender: Any) { //pressed
        //super.addPlayer(name: "Hanna")
        //addPlayerTxtField.isEnabled = true
        addPlayerTxtField.becomeFirstResponder()
    }
    
    func deletePlayer(index: Int) {
        super.removePlayer(index: index)
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Override händer")
        
        let destinationVC = segue.destination as! SubjectViewController
        destinationVC.recievingName = nil
    }
    
    @IBAction func unwindToHere(segue: UIStoryboardSegue) {
        print("Tillbaka till Start")
        
    }
    
    
    //DataSource och delegat for collectionviewn
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return super.playerArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayerCollectionViewCell
        let cellIndex = indexPath.item
        
        cell.nameLbl.text = playerArray[cellIndex].getName()
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //addPlayerTxtField.backgroundColor = super.bgColor
        //addPlayerTxtField.isEnabled = false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if addPlayerTxtField.isFirstResponder {
            super.addPlayer(name: addPlayerTxtField.text!)
            
            addPlayerTxtField.resignFirstResponder()
            addPlayerTxtField.text = nil
            addPlayerTxtField.backgroundColor = .white
            
            self.playerCollectionView.reloadData()
            
        }
        return true
    }
    
    
}

