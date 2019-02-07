//
//  QuestionViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-04.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class QuestionViewController: StylingViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    
    var recievingSubject: String?
    var recievingType: String?
    var type: String?
    
    private let points = [1,2,3,4,5]
    
    let segId = "placeholderSegueToScoreId" //segueToScoreId
    @IBOutlet weak var dareQuestionLbl: UILabel!
    @IBOutlet weak var pointPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dareQuestionLbl.text = dareQuestionPicker()
        pointPicker.sizeToFit() //TODO TITTA PÅ DENNA
        
    }
    
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
        
        return "\(pointValues) pts"
    }
    
    
   
    func dareQuestionPicker() -> String {
        
        //Random fråga med subject och type specifierad
        
        return "\(recievingSubject ?? "Romance") : \(recievingType ?? "Truth") : Have you ever peed in the pool?"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == segId {
            
            let cell = sender as! UIButton//UICollectionViewCell

            let btnName =  cell.titleLabel?.text  as! String

            
            let destinationVC = segue.destination as! ScoreViewController
            destinationVC.recievingName = btnName
            let index = points[pointPicker.selectedRow(inComponent: 0)]
            destinationVC.recievingPoint = index
            
        }
        
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
