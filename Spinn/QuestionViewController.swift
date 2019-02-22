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
    var rotAngle: CGFloat = 0.0
    
    private let points = [0,1,2,3,4,5]
    
    let alert = UIAlertController(title: NSLocalizedString("rate", comment: ""), message: NSLocalizedString("rate_instructions", comment: "") , preferredStyle: .alert)
    
    let segId = "segueToScoreId" //"placeholderSegueToScoreId"
    @IBOutlet weak var dareQuestionLbl: UILabel!
    @IBOutlet weak var pointPicker: UIPickerView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var forLbl: UILabel!
    @IBOutlet weak var  collectionView : UICollectionView!
    @IBOutlet weak var instructBtn: MyRoundedButton!
    
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
        
        //initialize alert msg
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        //changes based on background color
        changesOnSubjectChoosen()

    }
    
    //Hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //Need the viewLoad to happen before we get the size of the frame
    override func viewDidLayoutSubviews() {
        //layout for collectionview
        cvLayout()
        // Make pointpicker horizontal
        pVLayout()

    }
    
    @IBAction func instructBtnPressed(_ sender: Any) {
        self.present(alert,animated: true)
        
    }
    // Make pointpicker horizontal
    func pVLayout() {
        
        //reset the frame
        //old y position
        let w = pointPicker.frame.origin.y //orginal w spot
        //let no = pointPicker.frame.width
        rotAngle = -90 * (.pi/180)  // - to get the 0 on the left
        pointPicker.transform = CGAffineTransform(rotationAngle: rotAngle) //radiant angle
        
        //where to position the pv
        pointPicker.frame = CGRect(x: -100, y: w, width: (view.frame.width + 200), height: 60)  //100 is the height of the original pv from storyboard
        //wont be all the way to the edge so can add 100ish to stretch it on each side (x -100, y +100 so + 200 on width
    
    }
    
    func changesOnSubjectChoosen() {
        //Set the background to the topics color
        view.backgroundColor = recievingColor
        
        if recievingSubject == "physical_topic" {//
            dareQuestionLbl.textColor = .white
            rateLbl.textColor = .white
            instructBtn.layer.borderColor = UIColor.red.cgColor
        } else if recievingSubject == "romance_topic" {
            instructBtn.setTitleColor(UIColor.black, for: .normal)
        }
        
        switch recievingType?.lowercased() {
        case "truth",
                "",
                nil:
            rateLbl.text = NSLocalizedString("rate_truth", comment: "")
        case "dare":
            rateLbl.text = NSLocalizedString("rate_dare", comment: "")
        default:
            rateLbl.text = NSLocalizedString("rate_truth", comment: "")
        }
        
        forLbl.text = NSLocalizedString("rate_player", comment: "")
        
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
//        collectionView.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
        
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
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        collectionView.flashScrollIndicators()
    }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pLbl = UILabel()
        pLbl.font = UIFont(name: btnFont  , size: CGFloat(btnSize))
        pLbl.textAlignment = .center
        pLbl.text = "\(String(points[row]))"
        // NSLocalizedString("\(String(points[row])) \(NSLocalizedString("pts", comment: ""))", comment: "")
        
        //Choose text color in the picker
        if recievingSubject?.lowercased() == "physical_topic" {//
            pLbl.textColor = UIColor.white
            forLbl.textColor = UIColor.white
            
        }else{
            pLbl.textColor = UIColor.black
        }
        
        //make horizontal text after changing the direction of the picker the text is twisted with it, set the lbls degrees as opposit that of the PV
        pLbl.transform = CGAffineTransform(rotationAngle: (90 * (.pi/180)))
        
        return pLbl
    }
    
    
    //collectionView delegare and datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print("Spelare är.. \(Players.playerArray.count)")
        
        return Players.playerArray.count
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuestionCollectionViewCell
        
        let cellIndex = indexPath.item
        
        //let name = "No\(cellIndex)"
        
        cell.nameBtn.isEnabled = true

        cell.nameBtn.setTitle(Players.playerArray[cellIndex].getName(), for: .normal )
        cell.nameBtn.setTitleColor( recievingColor, for: .normal)
        cell.nameBtn.backgroundColor = UIColor.white
        
        cell.nameBtn.layer.cornerRadius = 10
        cell.nameBtn.layer.borderWidth = 2
        cell.nameBtn.layer.borderColor = UIColor.black.cgColor
        
        cell.nameBtn.tag = cellIndex
        
        //cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        return cell
    }
    
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //print("I QUESTION SEGUE")
    
        if segue.identifier == segId {
            
            let cell = sender as! UIButton//UICollectionViewCell

            let btnName =  cell.titleLabel!.text  //as! String

            let pointsToAdd = points[pointPicker.selectedRow(inComponent: 0)]
            //let playerNumber = cell.tag
            //print(playerNumber)
            
            //add points to player
            editPlayers.addPlayerPoints(playerName: btnName!, points: pointsToAdd)
           
            
            //Players.playerArray[playerNumber].addingPoints(addPoints: pointsToAdd)
            
            let destinationVC = segue.destination as! ScoreViewController
            
            destinationVC.recievingName = btnName

            
        }
        
    }

}


//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        let pointValues = points[row]
//
//        return "\(pointValues) \(NSLocalizedString("pts", comment: ""))"
//    }

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
