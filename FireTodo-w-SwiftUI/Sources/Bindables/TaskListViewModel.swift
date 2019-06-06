//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Combine
import SwiftUI
import Firebase

final class TaskListViewModel: BindableObject {
    let didChange: AnyPublisher<TaskListViewModel, Never>
    private let _didChange = PassthroughSubject<TaskListViewModel, Never>()
    private lazy var taskAssign = Subscribers.Assign(object: self, keyPath: \.tasks)
    let user: Document<Model.User>
    var tasks: [Document<Model.Task>] = [] {
        didSet {
            _didChange.send(self)
        }
    }
    init(user: Document<Model.User>) {
        self.user = user
        didChange = _didChange.eraseToAnyPublisher()

        Document<Model.Task>.listen(parentDocument: user)
            .replaceError(with: [])
            .receive(subscriber: taskAssign)
    }

    func create(text: String, color: TaskColor) {
        Document<Model.Task>.create(parentDocument: user, model: .init(text: text, color: color)) { _ in }
    }

    func toggleDone(_ task: Document<Model.Task>) {
        task.update(fields: [.isDone: !task.data.isDone])
    }

    func delete(_ task: Document<Model.Task>) {
        task.delete()
    }

    deinit {
        taskAssign.cancel()
    }
}
