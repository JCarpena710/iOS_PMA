//
//  WishListViewController.swift
//  semana7
//
//  Created by MAC07 on 22/11/21.
//

import UIKit
import FirebaseFirestore

class WishListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // let places: [String] = ["Sur", "Chosica", "Mancora", "Vichayito Piura Perú"]
    
    // let descriptions: [String] = ["4 - 6 Dic", "4 - 6 Dic", "4 - 6 Nov", "24 - 26 Dic"]
    
    var placesWhishList = [Wish]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getDataFromFirebase()
    
    }
    
    func setUp() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getDataFromFirebase() {
            db.collection("whishlist").getDocuments() {
                querySnapshot, err in
                
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                self.placesWhishList.removeAll()
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let documentId = document.documentID
                    let name = data["name"] as? String
                    let address = data["address"] as? String
                    let photo = data["photo"] as? String
                    let rating = data["rating"] as? String
                    let useRatingTotal = data["useRatingTotal"] as? String
  
                    let wish = Wish(documentId: documentId, name: name!, address: address!, rating: rating!, userRatingsTotal: useRatingTotal!, photo: photo!)
                    self.placesWhishList.append(wish)
                }
            
                self.tableView.reloadData()
                
            }
        }
    

}

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return placesWhishList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let object = placesWhishList[indexPath.section]
        cell.textLabel?.text = object.name
        cell.detailTextLabel?.text = object.address
        
        setUpImage(photo: object.photo, image: cell.imageView!)
        
        cell.imageView?.layer.cornerRadius = 8
        cell.imageView?.layer.masksToBounds = true
        


        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = placesWhishList[indexPath.section]
        
        print(object.documentId)
        
        
        let alert = UIAlertController(title: "Eliminar", message: "Seguro que desea eliminar esto de su lista de favoritos", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {_ in
            self.db.collection("whishlist").document(object.documentId).delete() {
                err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    self.getDataFromFirebase()
                }
            }
            print(object.documentId)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return UITableViewCell.EditingStyle.delete
        } else {
            return UITableViewCell.EditingStyle.delete
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
}
