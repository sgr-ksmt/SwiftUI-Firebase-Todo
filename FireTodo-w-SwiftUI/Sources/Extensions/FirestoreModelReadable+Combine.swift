//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation
import Firebase
import Combine

extension Document where T: FirestoreModelReadable {
    static func listen<U>(parentDocument: Document<U>, queryBuilder: @escaping (Query) -> Query = { $0 }, includeMetadataChanges: Bool = false) -> AnyPublisher<[Document<T>], Error> {
        AnyPublisher<[Document<T>], Error> { subscriber in
            let listener = listen(parentDocument: parentDocument, queryBuilder: queryBuilder, includeMetadataChanges: includeMetadataChanges) { result in
                switch result {
                case let .success(models):
                    _ = subscriber.receive(models)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            }
            subscriber.receive(subscription: AnySubscription(listener.remove))
        }
    }
}
