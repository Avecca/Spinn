//
//  ScoreViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-04.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class ScoreViewController: StylingViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    
    let segId = "unwindToSubjectViewId"
    let segToStartId = "unwindToStartId"
    var recievingName : String?
    private let editPlayers = EditPlayers()
    
    @IBOutlet weak var nextBtnPressed: UIButton!
    @IBOutlet weak var scoreConnectionView : UICollectionView!
    @IBOutlet weak var quitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreConnectionView.delegate = self
        scoreConnectionView.dataSource = self
        
        //Create Array ordered after points for the players, that is used to fill the collectionView
        editPlayers.orderPlayerArray() 
        
        
        //TODO FIXA NAMNET
        nextBtnPressed.setTitle(NSLocalizedString("next_btn", comment: ""), for: .normal)
        quitBtn.setTitle(NSLocalizedString("quit_btn", comment: ""), for: .normal)
        

//        for i in orderedList {
//            print("ordered  \(i)")
//        }
//
//        for i in Players.playerArray {
//            print("playerarray \(i)")
//        }
    }
    
    //collectionview delegate and datascource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Players.orderedArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScoreCollectionViewCell
        let cellIndex = indexPath.item
        
        cell.nameLbl.text = Players.orderedArray[cellIndex].getName()
        cell.scoreLbl.text = "\(Players.orderedArray[cellIndex].getPoints()) \(NSLocalizedString("score_pts", comment: "")) "
        cell.nameLbl.tag = cellIndex
        cell.scoreLbl.tag = cellIndex
        
        if Players.orderedArray[cellIndex].getName() == recievingName {
            cell.nameLbl.textColor = .white
            cell.scoreLbl.textColor = .white
        }
        
        return cell
    }
    
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == segId {
//             print("NextBtn CLICK!")
//        }  om unwindToSubjectViewId i score view controller scene unwind segue identifier
        
        if segue.identifier == segId {
            let destinationVC = segue.destination as! SubjectViewController
            
            if let name = recievingName{
                //print("Not empty name")
                destinationVC.topicLbl.text = "\(name) \(NSLocalizedString("choose_topic_lbl", comment: "").lowercased())"
            }
            
            //print("NextBtn CLICK!")
        }
        
        if segue.identifier == segToStartId {
            
           // print("Quitting the game")

           //Remove all Players
           editPlayers.nilPlayerArray()
            
        }
    }
    
    //prepareForUnwind
    
//    @IBAction func unwindToSubjectView(segue: UIStoryboardSegue) {
//        performSegue(withIdentifier: segId, sender: self)
//    }
//    @IBAction func nextBtnClick(_ sender: Any) {
//
//
//        //performSegue(withIdentifier: segId, sender: self)
//    }
//
//     @IBAction func nextClick(_ sender: Any) {
//        print("NextBtn CLICK!")
//        self.performSegue(withIdentifier: segId, sender: self)
//     }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
