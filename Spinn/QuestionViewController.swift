//
//  QuestionViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-04.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource {

    

    
    
    var recievingSubject: String?
    var recievingType: String?
    var recievingColor : UIColor?
    var type: String?
    let maxQuestions = 10
    let defaultType = "_truth"
    let defaultSubject = "oppsies_topic"
    private let editPlayers = EditPlayers()
    let btnFont = "Rockwell-Bold"
    let btnSize = 22
    
    private let points = [0,1,2,3,4,5]
    
    let segId = "segueToScoreId" //"placeholderSegueToScoreId"
    @IBOutlet weak var dareQuestionLbl: UILabel!
    @IBOutlet weak var pointPicker: UIPickerView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var  collectionView : UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //fetch the question/dare
        dareQuestionLbl.text = NSLocalizedString(dareQuestionPicker(), comment: "")
        
        //default value for the point picker
        pointPicker.sizeToFit() //TODO TITTA PÅ DENNA
        let defaultPointValue = points.count / 2
        pointPicker.selectRow(defaultPointValue, inComponent: 0, animated: false)
 
        
        //delegate and datasource for picker
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //changes based on background color
        changesOnSubjectChoosen()
        
        //layout for collectionview
        cvLayout()
  
    }
    
    func changesOnSubjectChoosen() {
        //Set the background to the topics color
        view.backgroundColor = recievingColor
        
        if recievingSubject == "physical_topic" {//
            dareQuestionLbl.textColor = .white
            rateLbl.textColor = .white
        }
    }
    
    
    func cvLayout()  {
        let width = (view.frame.size.width)
        let height = view.frame.size.height
        let bounds = collectionView.bounds
        let layout  = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellSize = (height < width) ? bounds.height/2 : bounds.width/2
        //-20 bc min spacing -100 bc not square
        layout.itemSize = CGSize(width: cellSize - 20, height: cellSize - 110)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        //collectionview filled from bottom
        collectionView.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
        
        
    }
    
    
    //fetch the question/dare
    func dareQuestionPicker() -> String {
        
        //Random fråga med subject och type specifierad
        
        let rdm = Int.random(in: 1 ... maxQuestions)
        
        //create string with pattern friendship_topic_truth_1 based on topic, truth or dare and a random number
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
    
    
    //Pickerview Delegate and datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //1 rad i pickern används
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //antal värden i pickern
        return points.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        let pointValues = points[row]
//
//        return "\(pointValues) \(NSLocalizedString("pts", comment: ""))"
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        collectionView.flashScrollIndicators()
    }
//
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//
//
//        //Choose text color in the picker
//        if recievingSubject?.lowercased() == "physical_topic" {//
//
//            let textWithColor = NSAttributedString(string: "\(String(points[row])) \(NSLocalizedString("pts", comment: ""))", attributes: [NSAttributedString.Key.foregroundColor :
//            UIColor.white])
//            return textWithColor
//        }
//
//
//       return  NSAttributedString(string: "\(String(points[row])) \(NSLocalizedString("pts", comment: ""))" , attributes: [NSAttributedString.Key.foregroundColor :
//            UIColor.black])
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pLbl = UILabel()
        pLbl.font = UIFont(name: btnFont  , size: CGFloat(btnSize))
        pLbl.textAlignment = .center
        pLbl.text = NSLocalizedString("\(String(points[row])) \(NSLocalizedString("pts", comment: ""))", comment: "")
        
        //Choose text color in the picker
        if recievingSubject?.lowercased() == "physical_topic" {//
            
            pLbl.textColor = UIColor.white
            
           
        }else{
            pLbl.textColor = UIColor.black
            
        }
        
        
        return pLbl
    }
    
    
    //collectionView delegare and datasource

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print("Spelare är.. \(super.players.playerArray.count)")
        
        //        guard Players.playerArray.count > 0  else {
        //            print("spelare är inte > 0")
        //            return 0
        //        }
        
        //print("Spelare är.. \(Players.playerArray.count)")
        
        return Players.playerArray.count
        
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
         cell.nameBtn.setTitle(Players.playerArray[cellIndex].getName(), for: .normal )
        cell.nameBtn.setTitleColor( UIColor.blue, for: .normal)
        cell.nameBtn.backgroundColor = UIColor.white
        
        cell.nameBtn.layer.cornerRadius = 10
        cell.nameBtn.layer.borderWidth = 2
        cell.nameBtn.layer.borderColor = UIColor.black.cgColor
        
        cell.nameBtn.tag = cellIndex
        
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        return cell
    }
    
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //print("I QUESTION SEGUE")
    
        if segue.identifier == segId {
            
            let cell = sender as! UIButton//UICollectionViewCell

            let btnName =  cell.titleLabel?.text  as! String

            let pointsToAdd = points[pointPicker.selectedRow(inComponent: 0)]
            let playerNumber = cell.tag
            //print(playerNumber)
            
            //add points to player
            editPlayers.addPlayerPoints(playerName: btnName, points: pointsToAdd)
           
            
            //Players.playerArray[playerNumber].addingPoints(addPoints: pointsToAdd)
            
            let destinationVC = segue.destination as! ScoreViewController
            
            destinationVC.recievingName = btnName

            
        }
        
    }

}
