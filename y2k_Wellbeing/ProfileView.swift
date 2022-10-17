//
//  ProfileView.swift
//  y2k_Wellbeing
//
//  Created by Kevin Sampson on 10/11/21.
//  This project is called Wellbeing and is a program that asks the user about their mental health
//  and allows the user to create journal entries so that they can record how their day was.
//  Copyright (C) 2021 Brian Boyle, Vikku Ponnaganti, Kevin Sampson
//  This file is part of Wellbeing.
//    Wellbeing is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Wellbeing is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Wellbeing.  If not, see <https://www.gnu.org/licenses/>.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import MobileCoreServices

class ProfileView: UIViewController {
    
    let firebaseAuth = Auth.auth()
    let currentUser = Auth.auth().currentUser
    let storage = Storage.storage()
    let notificationName = "uploadTaskDidComplete"
   
    @IBOutlet weak var displayEmail: UILabel!
    
    @IBOutlet weak var profile: UIImageView!
    
    @IBAction func selectMediaAction(_ sender: Any) {
        // Must import `MobileCoreServices`
        
        let user = Auth.auth().currentUser
        guard let user = user else {
          return
        }
        
        let imageMediaType = kUTTypeImage as String

        // Define and present the `UIImagePickerController`
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.mediaTypes = [imageMediaType]
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        profile.layer.cornerRadius = 25.0
        profile.layer.borderWidth = 2.0
        profile.layer.borderColor = UIColor.black.cgColor
        let user = Auth.auth().currentUser
        if let user = user {
          let email = user.email
          displayEmail.text = email
            
            if let photoURL = user.photoURL {
                profile.load(url: photoURL)
                
            }
        }
        
    }
    
    @IBAction func userManualBtn(_ sender: Any) {
        guard let url = URL(string: "https://docs.google.com/document/d/1cGXa33iYtVAA6hWoKQNJDCr7xvLmKqLEWapBQaGQ-s8/edit?usp=sharing") else { return }
        UIApplication.shared.open(url)
    }
    

    @IBAction func signoutBtn(_ sender: Any) {
        let signoutAlert = UIAlertController(title: "Warning", message: "Are you sure you would like to sign out?", preferredStyle: UIAlertController.Style.alert)

        signoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
            
            self.logout()
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myLogin")
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: false, completion: nil)
           
        }))

        signoutAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
            
        }))

        present(signoutAlert, animated: true, completion: nil)
    }
        
    func logout() {
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func uploadFile(fileUrl: URL) {
      do {
          let metaData = StorageMetadata()
          
        // Create file name
          let user = Auth.auth().currentUser
          guard let user = user else {
            return
          }
        let fileExtension = fileUrl.pathExtension
          let fileName = "\(user.uid).\(fileExtension)"

        let storageReference = Storage.storage().reference().child(fileName)
        let currentUploadTask = storageReference.putFile(from: fileUrl, metadata: metaData) { (storageMetaData, error) in
          if let error = error {
            print("Upload error: \(error.localizedDescription)")
            return
          }
                                                                                    
          // Show UIAlertController here
          print("Image file: \(fileName) is uploaded! View it at Firebase console!")
                                                                                    
          storageReference.downloadURL { (url, error) in
            if let error = error  {
              print("Error on getting download url: \(error.localizedDescription)")
              return
            }
            print("Download url of \(fileName) is \(url!.absoluteString)")
              
              self.updateProfilePic(photoURL: url!)
              
          }
        }
      } catch {
        print("Error on extracting data from url: \(error.localizedDescription)")
      }
    }
    
}

extension ProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // Check for the media type
    let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
    if mediaType == kUTTypeImage {
      let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! URL
      if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             profile.contentMode = .scaleAspectFit
             profile.image = pickedImage
            }

            dismiss(animated: true, completion: nil)
        
        // Handle your logic here, e.g. uploading file to Cloud Storage for Firebase
            uploadFile(fileUrl: imageURL)
        }
    }
    
    func updateProfilePic(photoURL: URL) {
     
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
           changeRequest.photoURL =
            photoURL as URL?
            changeRequest.commitChanges { error in
             if let error = error {
               // An error happened.
                 print("error while updating profile \(error)")
             } else {
               print("Profile updated..")
             }
           }
         }
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
