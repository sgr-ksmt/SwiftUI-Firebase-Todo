//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Combine
import SwiftUI
import Firebase

final class UserData: BindableObject {
    enum AuthState {
        case initial
        case notAuthenticated
        case authenticated(Document<Model.User>)
    }
    
    let didChange: AnyPublisher<UserData, Never>
    private let _didChange = PassthroughSubject<UserData, Never>()
    private lazy var authStateAssign = Subscribers.Assign(object: self, keyPath: \.authState)
    private let userDidCreate = PassthroughSubject<(), Never>()

    var authState: AuthState = .initial {
        didSet {
            _didChange.send(self)
        }
    }

    init() {
        didChange = _didChange.eraseToAnyPublisher()

        Auth.auth().stateDidChange()
            .map { $0.user }
            .merge(with: userDidCreate.map { Auth.auth().currentUser })
            .flatMap { authUser in
                AnyPublisher<Document<Model.User>?, Error> { subscriber in
                    guard let authUser = authUser else {
                        _ = subscriber.receive(nil)
                        subscriber.receive(completion: .finished)
                        return
                    }
                    Document<Model.User>.get(documentID: authUser.uid) { result in
                        switch result {
                        case let .success(user):
                            _ = subscriber.receive(user)
                            subscriber.receive(completion: .finished)
                        case let .failure(error):
                            subscriber.receive(completion: .failure(error))
                        }
                    }
                }
                .replaceError(with: nil)
            }
            .map { user in user.map { AuthState.authenticated($0)}  ?? .notAuthenticated }
            .receive(subscriber: authStateAssign)
    }

    func signIn(with name: String, completion: @escaping (Result<(), Error>) -> Void = { _ in }) {
        if let _ = Auth.auth().currentUser {
            return
        }

        Auth.auth().signInAnonymously { authDataResult, error in
            switch Result(authDataResult, error) {
            case let .success(authDataResult):
                Document<Model.User>.create(documentID: authDataResult.user.uid, model: .init(name: name)) { result in
                    switch result {
                    case .success:
                        completion(.success(()))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
    }

    deinit {
        authStateAssign.cancel()
    }
}
