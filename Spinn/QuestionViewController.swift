//
//  QuestionViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-04.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class QuestionViewController: StylingViewController, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource {

    

    
    
    var recievingSubject: String?
    var recievingType: String?
    var type: String?
    let maxQuestions = 10
    let defaultType = "_truth"
    let defaultSubject = "oppsies_topic"
    
    private let points = [0,1,2,3,4,5]
    
    let segId = "segueToScoreId" //"placeholderSegueToScoreId"
    @IBOutlet weak var dareQuestionLbl: UILabel!
    @IBOutlet weak var pointPicker: UIPickerView!
    
    @IBOutlet weak var  collectionView : UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //fetch the question/dare
        dareQuestionLbl.text = NSLocalizedString(dareQuestionPicker(), comment: "")
        
        //default value for the point picker
        pointPicker.sizeToFit() //TODO TITTA PÅ DENNA
        let defaultPointValue = points.count / 2
        pointPicker.selectRow(defaultPointValue, inComponent: 0, animated: false)
        
        
        
//        for i in super.players.playerArray {
//           print(i.getName())
//        }
        
        //print(super.players.playerArray)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
    }
    
    
    //Pickerview Delegate and datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //1 rad i pickern används
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //antal värden i pickern
        return points.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let pointValues = points[row]
        
        return "\(pointValues) \(NSLocalizedString("pts", comment: ""))"
    }
    
    
    //collectionView delegare and datasource

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print("Spelare är.. \(super.players.playerArray.count)")
        
        //        guard GamePlay.playerArray.count > 0  else {
        //            print("spelare är inte > 0")
        //            return 0
        //        }
        
        print("Spelare är.. \(GamePlay.playerArray.count)")
        
        //return super.players.playerArray.count
        
        return GamePlay.playerArray.count
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuestionCollectionViewCell
        
        let cellIndex = indexPath.item
        
//        guard super.players.playerArray.count > 0  else {
//            return cell
//        }
        //let name = "No\(cellIndex)"
        
        cell.nameBtn.isEnabled = true
//        cell.nameBtn.setTitle(super.players.playerArray[cellIndex].getName(), for: .normal )
         cell.nameBtn.setTitle(GamePlay.playerArray[cellIndex].getName(), for: .normal )
        cell.nameBtn.setTitleColor( UIColor.blue, for: .normal)
        cell.nameBtn.backgroundColor = UIColor.white
        
        cell.nameBtn.layer.cornerRadius = 10
        cell.nameBtn.layer.borderWidth = 2
        cell.nameBtn.layer.borderColor = UIColor.black.cgColor
        
        cell.nameBtn.tag = cellIndex
        
        
        return cell
    }
    
    
   
    //fetch the question/dare
    func dareQuestionPicker() -> String {
        
        //Random fråga med subject och type specifierad
        
        let rdm = Int.random(in: 1 ... maxQuestions)
        
        var truthDareString = ""
        
        //default value sin case something goes wrong
        if recievingSubject != nil {
            truthDareString = recievingSubject!
        } else {
            truthDareString = defaultSubject
        }
        
        if recievingType != nil {
            truthDareString += "_\(recievingType!)"
        }else{
            truthDareString += defaultType
        }
        
        
        truthDareString += "_\(rdm)"
        
//        let truthDareString = "\(recievingSubject! ?? "oppsies_topic")_\(recievingType! ?? "truth")_\(rdm)"
        
        
        return truthDareString
        //"\(recievingSubject ?? "Romance") : \(recievingType ?? "Truth") : Have you ever peed in the pool?"
    }
    
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //print("I QUESTION SEGUE")
    
        if segue.identifier == segId {
            
            let cell = sender as! UIButton//UICollectionViewCell

            let btnName =  cell.titleLabel?.text  as! String

            let pointsToAdd = points[pointPicker.selectedRow(inComponent: 0)]
            let playerNumber = cell.tag
            print(playerNumber)
            
            //add points to player
            GamePlay.playerArray[playerNumber].addingPoints(addPoints: pointsToAdd)
            
            let destinationVC = segue.destination as! ScoreViewController
            
            destinationVC.recievingName = btnName

            
        }
        
    
    }


}
