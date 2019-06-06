//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import SwiftUI

struct TaskListView : View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    @EnvironmentObject private var userData: UserData

    @State private var hideDoneTasks: Bool = true
    var body: some View {
        NavigationView {
            Group {
                CreateTaskView()

                Toggle(isOn: $hideDoneTasks) {
                    Text("Hide done tasks")
                    }
                    .padding(.horizontal)

                List {
                    ForEach(taskListViewModel.tasks.identified(by: \.self)) { task in
                        if !self.hideDoneTasks || !task.data.isDone {
                            TaskListRow(task: task)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Todo List"))
            .navigationBarItems(trailing:
                PresentationButton(
                    Image(systemName: "person.crop.circle").imageScale(.large),
                    destination: UserView(user: taskListViewModel.user).environmentObject(userData)
                )
            )
        }
    }
}

#if DEBUG
struct TaskListView_Previews : PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
#endif
