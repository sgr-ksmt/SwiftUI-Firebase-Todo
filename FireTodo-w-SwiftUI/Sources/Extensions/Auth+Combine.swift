//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Combine
import Firebase

extension Auth {
    func stateDidChange(auth: Auth = .auth()) -> AnyPublisher<(auth: Auth, user: Firebase.User?), Never> {
        AnyPublisher<(auth: Auth, user: Firebase.User?), Never> { subscriber in
            let listener = auth.addStateDidChangeListener { (auth, user) in
                _ = subscriber.receive((auth, user))
            }
            subscriber.receive(subscription: AnySubscription { auth.removeStateDidChangeListener(listener) })
        }
    }
}
