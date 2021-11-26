//
//  ProfileViewController.swift
//  semana7
//
//  Created by MAC07 on 25/11/21.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var lblName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        setUpView()
       
    }
    
    func setUpView() {
        image.layer.cornerRadius = image.frame.size.height / 2
        image.layer.borderWidth = 1
        image.layer.masksToBounds = true
    }
     
    
    func getUser() {
        let user = Auth.auth().currentUser
        lblEmail.text = user?.email!
        lblName.text = user?.displayName!
        
        let imageData = try? Data(contentsOf: (user?.photoURL!)!)
        
        if let data = imageData {
            image.image = UIImage(data: data)
        }
    }

    
    @IBAction func onClickLogout(_ sender: Any) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }


}
