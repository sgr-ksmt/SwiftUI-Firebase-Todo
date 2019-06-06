//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import SwiftUI

struct TaskListRow : View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    @State private var alertIsShown: Bool = false
    var task: Document<Model.Task>! = nil

    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            CheckBoxView(isChecked: self.task.data.isDone) {
                self.taskListViewModel.toggleDone(self.task)
            }

            Text(task.data.text).font(.title)

            Spacer()

            Image(systemName: "trash.fill").imageScale(.large)
                .disabled(false)
                .tapAction { self.alertIsShown = true }
                .presentation($alertIsShown) {
                    Alert(
                        title: Text("Confirm"),
                        message: Text("Delete this Task?\ntext: \(self.task.data.text)"),
                        primaryButton: .destructive(Text("Delete")) {
                            self.taskListViewModel.delete(self.task)
                        },
                        secondaryButton: .cancel()
                    )
                }
        }
        .padding()
        .background(task.data.color.color.opacity(0.8))
        .cornerRadius(8.0)
    }
}

#if DEBUG
struct TaskListRow_Previews : PreviewProvider {
    static var previews: some View {
        TaskListRow()
    }
}
#endif
