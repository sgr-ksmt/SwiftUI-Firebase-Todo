//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation
import Combine

// refer from: https://github.com/ra1028/SwiftUI-Combine/blob/master/SwiftUI-Combine-Example/AnySubscription.swift

final class AnySubscription: Subscription {
    private let cancellable: Cancellable

    init(_ cancel: @escaping () -> Void) {
        cancellable = AnyCancellable(cancel)
    }

    func request(_ demand: Subscribers.Demand) {}

    func cancel() {
        cancellable.cancel()
    }
}
