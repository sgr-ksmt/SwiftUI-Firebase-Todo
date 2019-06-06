//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI

extension Model {
    struct Task: FirestoreModelReadable, FirestoreModelWritable {
        enum Field: String {
            case text
            case color
            case isDone
        }

        static func subCollectionRef(of document: DocumentReference) -> CollectionReference {
            document.collection("tasks")
        }

        var text: String = ""
        var color: TaskColor = .default
        var isDone: Bool = false

        init(snapshot: DocumentSnapshot) {
            text = snapshot.stringValue(forKey: Field.text, default: "")
            color = TaskColor(rawValue: snapshot.stringValue(forKey: Field.color, default: "")) ?? .default
            isDone = snapshot.boolValue(forKey: Field.isDone, default: false)
        }

        init(text: String, color: TaskColor, isDone: Bool = false) {
            self.text = text
            self.color = color
            self.isDone = isDone
        }

        var writeFields: [Field: Any] {
            return [
                .text: text,
                .color: color.rawValue,
                .isDone: isDone
            ]
        }
    }
}
