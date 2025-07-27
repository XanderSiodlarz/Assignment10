//
//  NoteModel.swift
//  Notes
//
//  Created by Xander The Boss on 7/22/25.
//

import Foundation
import FirebaseFirestore
struct NoteModel : Codable, Identifiable {
    @DocumentID var id : String?
    var title : String
    var content : String
}
