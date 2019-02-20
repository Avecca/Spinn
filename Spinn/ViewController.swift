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
    private let editPlayers = EditPlayers()
    
    @IBOutlet weak var addPlayerTxtField: UITextField!
    @IBOutlet weak var playerCollectionView: UICollectionView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var langbtn: UIButton!
    

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
        
        //collectionview filled from bottom
        playerCollectionView.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))

        
        
        //if reload hide or show things again
        showCorrect()
        
    }
    
    
    func showCorrect()   {
        if Players.playerArray.isEmpty {
            
            playBtn.isHidden = true
            //playersTitleLbl.isHidden = true
        } else {
            playBtn.isHidden = false
            //playersTitleLbl.isHidden = false
            
        }
    }
    


    @IBAction func langBtnPressed(_ sender: Any) {
        //print(Locale.current.languageCode!)
        
        //Switch Languages
        switchLanguage()
        
//        let path = Bundle.main.path(forResource: "ar", ofType: "lproj")
//        let bundle = Bundle(path: path!)
//        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
//        delegate.window?.rootViewController = (storyboard.instantiateInitialViewController())
    }
    
   
    //Ready to play dyslexic style!
    @IBAction func rdyToiPlatBtn(_ sender: Any) {
        
        performSegue(withIdentifier: segueId, sender: self)
    }
    
    @IBAction func deletePlayerButtonPressed(_ sender: UIButton) {
        //print("Delete btn pressed!!")
        
        let index = sender.tag  //TODO check how to check this in if let
        
        //remove Player from the list
        editPlayers.removePlayer(index: index)
        
        //reload the listed view
        self.playerCollectionView.reloadData()
        //indicate that you can scroll in the collectionview
        playerCollectionView.flashScrollIndicators()
        
        //If empty list remove the ability to press play
        if Players.playerArray.isEmpty {
            //print("array tom efter delete!")
            playBtn.isHidden = true
        }
    }
    
 
    
    @IBAction func addPlayer(_ sender: Any) { //pressed
        //when clicking add, activate the textfield
        addPlayerTxtField.becomeFirstResponder()
        
        //When adding players make certain things available
        //playersTitleLbl.isHidden = false
        addPlayerTxtField.isHidden = false
        playerCollectionView.flashScrollIndicators()
    }
    
    
    
    //switch between the 2 predefined languages
    func switchLanguage(){
        if let switchToLang = (langbtn.titleLabel!.text)?.lowercased()
        {
            if switchToLang == "svenska" {
                Bundle.set(language: Language.svenska)
            }
            else{
                //default engelska
                Bundle.set(language: Language.english)
            }
            // Bundle.set(language: swi)
            
            
            //reload the viewcontroller to reflect the changes
            let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewControllerID")
            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            rootviewcontroller.rootViewController = firstVC
            
        }
    }
    
    
    //DataSource och delegat for collectionviewn
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return super.players.playerArray.count
        return Players.playerArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayerCollectionViewCell
        let cellIndex = indexPath.item
        
        print(Players.playerArray.count)

        cell.nameLbl.text = Players.playerArray[cellIndex].getName() //super.players.playerArray[cellIndex].getName()
        
        cell.deleteBtn.isHidden = false
        cell.deleteBtn.tag = cellIndex
        
        //Make sure the names arnt upside down since we reversed the order of the cv
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)

        
        
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
        addPlayerTxtField.isHidden = true
        if !Players.playerArray.isEmpty {
           // print("INte tom!")
            playBtn.isHidden = false
        }
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if addPlayerTxtField.isFirstResponder {
            
                    if( !Players.playerArray.contains(where: { $0.getName()  == addPlayerTxtField.text!})) {
                        
                        //change the player array
                        if let player = addPlayerTxtField.text {
                            editPlayers.addPlayer(name: player)
                                //Players.playerArray.append(Player(player))
                        }
                    } else {
                        //TODO POPUP KANSSKE?
                    }

            addPlayerTxtField.resignFirstResponder()
            addPlayerTxtField.text = nil
            addPlayerTxtField.backgroundColor = .white
            //reload the view to reflect changes
            self.playerCollectionView.reloadData()
            
            //scroll latest addition
            if Players.playerArray.count > 0 {
                self.playerCollectionView.scrollToItem(at: //scroll collection view to indexpath
                    NSIndexPath.init(row:(self.playerCollectionView?.numberOfItems(inSection: 0))!-1, //get last item of self collectionview (number of items -1)
                        section: 0) as IndexPath //scroll to bottom of current section
                    , at: UICollectionView.ScrollPosition.bottom, //right, left, top, bottom, centeredHorizontally, centeredVertically
                    animated: true)
            }
        }
        return true
    }
    

    
    //segue to next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //print("Override händer med \(super.players.playerArray.count) players")
        print("Override händer med \(Players.playerArray.count) players")
        
        let destinationVC = segue.destination as! SubjectViewController
        destinationVC.recievingName = nil
    }
    
    //return segue
    @IBAction func unwindToHere(segue: UIStoryboardSegue) {
        // print("Tillbaka till Start")
        self.playerCollectionView.reloadData()
        playBtn.isHidden = true
        
    }
    
    
}


//If adding more languages add them in language.swift as well
//var languages: [Language] = [.english, .swedish]

//
//extension String {
//    func localized(_ lang:String) ->String {
//
//        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
//        let bundle = Bundle(path: path!)
//
//        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//    }}



//    func deletePlayer(index: Int) {
//        //super.removePlayer(index: index)
//        super.players.removePlayer(index: index)
//
//    }

//
//let lang = "en"
//let path = Bundle.main.path(forResource: lang, ofType: "lproj")
//let bundle = Bundle(path: path!)
//
//return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
