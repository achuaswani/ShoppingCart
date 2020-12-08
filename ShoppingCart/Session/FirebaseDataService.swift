//
//  FirebaseDataService.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

import FirebaseDatabase
import FirebaseAuth
import CodableFirebase
import FirebaseStorage

class FirebaseDataService : ObservableObject {
    @Published var profile: Profile?

    func retrieveData() {
        let currentUser = Auth.auth().currentUser!
        let currentUserRef = Database.database().reference().child("Profile").child(currentUser.uid)
        
        currentUserRef.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let value = snapshot.value else { return }
            do {
                self?.profile = try FirebaseDecoder().decode(Profile.self, from: value)
            } catch let error {
                debugPrint(error)
            }
        })
    }
        
    func updateProfile(userValue: Profile, handler: @escaping (Error?) -> Void) {
        let currentUser = Auth.auth().currentUser!
        let db = Database.database().reference().child("Profile").child(currentUser.uid)
        let data = try! FirebaseEncoder().encode(userValue)
        db.setValue(data) { error, _ in
            handler(error)
            self.retrieveData()
        }
    }
    
    func updateDisplayPicture(filePath: URL, profileData: Profile) {
        let currentUser = Auth.auth().currentUser!
        let storage = Storage.storage()
        let refernce = storage.reference().child("Profile").child(currentUser.uid).child("profile.jpg")
        let uploadTask = refernce.putFile(from: filePath, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          refernce.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                  return
                }
                self.profile = profileData
                self.profile?.image = downloadURL.absoluteString
                self.updateProfile(userValue: self.profile!) { error in
                    debugPrint(error.debugDescription)
                }
          }
        }
        
    }
}
