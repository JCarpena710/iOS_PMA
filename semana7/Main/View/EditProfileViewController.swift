//
//  EditProfileViewController.swift
//  semana7
//
//  Created by MAC07 on 25/11/21.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var imagePicker = UIImagePickerController()
    var imagePathName: URL? = nil
    var imageUrlProfile: String? = ""
    var imageProfile: URL? = nil
    
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()

    }
    
    func getUser() {
        if let user = Auth.auth().currentUser {
            txtEmail.text = user.email!
            
            if let name = user.displayName {
                txtName.text = name
            }
            
            if let profile = user.photoURL {
                setImageURl(url: profile, image: profileImage)
                imageProfile = profile
            }
            
        }
    }
     
    
    @IBAction func onClickClose(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onClickOpenSource(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: "Camara", style: .default, handler: nil)
        
        let actionGallery = UIAlertAction(title: "Galeria", style: .default) {_ in
             self.openGallery()
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(actionCamera)
        alert.addAction(actionGallery)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func openGallery() {
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
        }
        
        imagePathName = (info[UIImagePickerController.InfoKey.imageURL] as? URL)!
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func onClickSave(_ sender: Any) {
        if imagePathName == nil {
            storeProfile(url: imageProfile)
        } else {
            uploadPhoto()
        }
    }
    
    
    func uploadPhoto() {
        let fileExtension = imagePathName!.pathExtension
        let fileName = "image\(Int.random(in: 1...1000)).\(fileExtension)"
        
        let storeRef = storage.reference()
        let profileRef = storeRef.child("profile").child(fileName)
        
        profileRef.putFile(from: imagePathName!, metadata: nil) {
            metadata, error in
            
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else {
                profileRef.downloadURL { (url, error) in
                    self.storeProfile(url: url!)
                    self.imageUrlProfile = String(describing: url!)
                }
            }
        }
    }
    
    func storeProfile(url: URL?) {
        let name = txtName.text
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = url
        changeRequest?.commitChanges { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
      
    
    
}
