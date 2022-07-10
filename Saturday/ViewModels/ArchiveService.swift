//
//  ArchiveService.swift
//  Saturday
//
//  Created by Titus Lowe on 10/7/22.
//

import Foundation
import Firebase

struct ArchiveService {
    
    func fetchArchives(withUid uid: String, completion: @escaping([Archive]) -> Void) {
        Firestore.firestore().collection("history")
            .document(uid)
            .collection("archives")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let archives = documents.compactMap({ try? $0.data(as: Archive.self) })
                completion(archives)
            }
    }

}
