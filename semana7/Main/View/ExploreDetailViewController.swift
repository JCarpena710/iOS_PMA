//
//  ExploreDetailViewController.swift
//  semana7
//
//  Created by MAC07 on 24/11/21.
//

import UIKit
import FirebaseFirestore

class ExploreDetailViewController: UIViewController {

    // MARK: - Varibles de entrada
    var name: String? = nil
    var address: String? = nil
    var rating: String? = nil
    var useRatingTotal: String? = nil
    var photo: String? = nil
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    
    // MARK: - Variable de mi lista
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRevies: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var message: UIButton!
    
    
    @IBOutlet weak var changeDate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpImage(photo: photo!, image: image)
        setUpButtons()
    }
    
    // MARK: - Funciones
    func setUpView() {
        lblName.text = name!
        lblAddress.text = address!
        lblRating.text = rating!
        lblRevies.text = useRatingTotal!
        
    }
    
    // MARK: - SetUpButton
    func setUpButtons() {
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.setTitle("", for: .normal)
        location.setTitle("", for: .normal)
        message.setTitle("", for: .normal)
        changeDate.layer.cornerRadius = 8
        changeDate.layer.masksToBounds = true
    }
    
    

    
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnSaveWhish(_ sender: Any) {
        //        Guardar la información de esta en firestore
                let data: [String: Any] = [
                    "name": name! as Any,
                    "address": address! as Any,
                    "rating" : rating! as Any,
                    "useRatingTotal": useRatingTotal! as Any,
                    "photo": photo! as Any
                ]
                
                ref = db.collection("whishlist").addDocument(data: data) { [self]
                    err in
                    if let err = err {
                        print("Error en \(err.localizedDescription)")
                    } else {
                        // puedo sacar el id
                        alertSuccess()
                        print(self.ref!.documentID)
                    }
                }
    }
    
    func alertSuccess() {
        let alert = UIAlertController(title: "Felicidades", message: "Se agrego \(name!) a tu lista de favoritos", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) {_ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
