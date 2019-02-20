//
//  SubjectViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-01-25.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class SubjectViewController: StylingViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var recievingName: String?
    var subjectArray  = [("friendship_topic"),("romance_topic"),("parties_topic"),("physical_topic"),("psyche_topic"),("oppsies_topic")]
     //var subjectArray  = [("Friendship"),("Romance"),("Parties"),("Physical"),("Psyche"),("Oppsies")] //: [String]
    var subjectColor : [UIColor] = [(UIColor.blue),(UIColor.red),(UIColor.purple),(UIColor.black),(UIColor.brown),(UIColor.orange)]
 
    let segId = "segueToSpinnId"
    var subject : String?


    //connection mellan SubjectCollectionViewCell och här genom namnet subjectCollectionView, hittas genom connectioninspectorn på storyboardet på sidans subjectviewcontroller
    //tryck på cellen i view controller scene och välj klassen
    @IBOutlet weak var subjectCollectionView: UICollectionView!
    @IBOutlet weak var topicLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

      //Connecta viecontrollrn till denna datasource and delegate
        subjectCollectionView.delegate = self
        subjectCollectionView.dataSource = self
       // print("recieving name is \(recievingName)")
        
       // print("Subjectsida händer med \(Players.playerArray.count) players")
       
        //If not second time here
        topicLbl.text = NSLocalizedString("choose_topic_lbl", comment: "")
        
        //collectionview filled from bottom
        subjectCollectionView.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjectArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //där "cell" är nmanet jag gav till alla cell object i attribut inspektorn
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubjectCollectionViewCell
        
        
        
        let cellIndex = indexPath.item
        cell.subjectBtnView.isEnabled = true
       
       cell.subjectBtnView.setTitle(NSLocalizedString(subjectArray[cellIndex], comment: ""), for: .normal)
        //cell.subjectBtnView.setTitleColor(subjectColor[cellIndex], for: .normal)
        cell.subjectBtnView.setTitleColor((subjectColor[cellIndex]), for: .normal)
        cell.subjectBtnView.titleLabel?.font = UIFont(name: super.btnFont, size: CGFloat(super.btnSize))
        cell.subjectBtnView.layer.borderColor = (subjectColor[cellIndex]).cgColor
        cell.subjectBtnView.backgroundColor = UIColor.white
        cell.subjectBtnView.tag = cellIndex
        //cell.accessibilityIdentifier = subjectArray[cellIndex]
        //print("\(cell.tag) as tag")
       // print("\(cell.accessibilityIdentifier)")
        
        
        //not upside down
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        return cell
        
        
    }
    
    //segue to SpinnViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // print("Testing \(subject) is nil")
      
        if segue.identifier == segId {
            
            let cell = sender as! UIButton//UICollectionViewCell
            let cellIndex = cell.tag
            
            let selectedSubject = subjectArray[cellIndex]
            
            //let color = cell.currentTitleColor
            //cell.titleLabel?.text  as! String
            let btnColor = cell.titleColor(for: .normal)
          //  print("\(btnColor) btncolor funkar")
         //   print("prepare  \(btnSubject) is not nil")
           // print(selectedSubject)
            
            let destinationVC = segue.destination as! SpinnViewController
            destinationVC.recievingSubject = selectedSubject
            
            if let color = btnColor{
                destinationVC.recievingColor = color
            }
            
        }
        
    }
    //unwind segue
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        print("Tillbaka till SubjectVC")
        
       //From ScoreViewController, sets recievingname
    }
    



}




//    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubjectCollectionViewCell
//        //self.performSegueWithIdentifier("yourSegueIdentifier", sender: self)
//        print("clickat")
//        if let text = cell.subjectBtnView.titleLabel?.text { //currentTitle!
//            subject = text
//            print(subject)
//        }
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("menforfan")
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubjectCollectionViewCell
//        let index =  cell.subjectBtnView.titleLabel?.text
//        subject = index
//
//    }

