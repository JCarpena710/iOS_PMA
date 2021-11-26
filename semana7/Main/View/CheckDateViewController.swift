//
//  CheckDateViewController.swift
//  semana7
//
//  Created by MAC07 on 24/11/21.
//

import UIKit

class CheckDateViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var calendarPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        backButton.setImage(UIImage(named: "cancel"), for: .normal)
        backButton.setTitle("", for: .normal)
    }

    @IBAction func onClickCalendar(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        lblDate.text = formatter.string(from: calendarPicker.date)
 
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
