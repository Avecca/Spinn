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
    let btnFont = "Rockwell-Bold"
    let btnSize = 32
    var subjectArray  = [("Friendship"),("Romance"),("Mishaps"),("Physical"),("Awkward"),("Oppsies")] //: [String]
    var subjectColor : [UIColor] = [(UIColor.blue),(UIColor.red),(UIColor.purple),(UIColor.black),(UIColor.brown),(UIColor.orange)]
 
    let segId = "segueToSpinnId"
    var subject : String?

    
    
    //connection mellan SubjectCollectionViewCell och här genom namnet subjectCollectionView, hittas genom connectioninspectorn på storyboardet på sidans subjectviewcontroller
    @IBOutlet weak var subjectCollectionView: UICollectionView!
    @IBOutlet weak var topicLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

      //Connecta viecontrollrn till denna datasource and delegate
        subjectCollectionView.delegate = self
        subjectCollectionView.dataSource = self
       // print("recieving name is \(recievingName)")
        
        //If not second time here
        topicLbl.text = "Choose Topic"
        

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
       
        cell.subjectBtnView.setTitle(subjectArray[cellIndex], for: .normal )
        //cell.subjectBtnView.setTitleColor(subjectColor[cellIndex], for: .normal)
        cell.subjectBtnView.setTitleColor((subjectColor[cellIndex]), for: .normal)
        cell.subjectBtnView.titleLabel?.font = UIFont(name: btnFont, size: CGFloat(btnSize))
        cell.subjectBtnView.layer.borderColor = (subjectColor[cellIndex]).cgColor
        cell.subjectBtnView.backgroundColor = UIColor.white
        cell.tag = cellIndex
        //cell.accessibilityIdentifier = subjectArray[cellIndex]
        //print("\(cell.tag) as tag")
       // print("\(cell.accessibilityIdentifier)")
        return cell
        
        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Testing \(subject) is nil")
      
        if segue.identifier == segId {
            
            //let index = //self.index(ofAccessibilityElement: sender)
            let cell = sender as! UIButton//UICollectionViewCell
            //let index = collectionView!.ce
            //let index = self.collectionView!.indexPathForCell(cell)
           print(cell)
            
            //let hmm = cell.accessibilityIdentifier
           // print("\(hmm) as acess")
//
//            if (sender.isKindOfClass(UIButton)){
//
//            }
           // let selectedSubject = subjectArray[index.row]
            let btnSubject =  cell.titleLabel?.text  as! String //cell.tag
            let btnColor = cell.titleColor(for: .normal)
            print("\(btnColor) btncolor funkar")
            print("prepare  \(btnSubject) is not nil")
           // print(selectedSubject)
            
            let destinationVC = segue.destination as! SpinnViewController
            destinationVC.recievingSubject = btnSubject
            
            if let color = btnColor{
                destinationVC.recievingColor = color
            }
            
        }
        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        print("Tillbaka till SubjectVC")
        
    }
    
    
    //        //let cell = subjectCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  SubjectCollectionViewCell
       //ubjectCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubjectCollectionViewCell
    //
    //cell.subjectBtnView.setTitle(subjectArray[cellIndex], for: <#T##UIControl.State#>)
     //cell.subjectBtnView.setTitle(subjectArray[cellIndex], for: <#T##UIControl.State#>)
    



}
