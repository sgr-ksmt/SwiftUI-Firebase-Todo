//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import SwiftUI

struct CreateTaskView : View {
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    @State private var draftText: String = ""
    @State private var selectedColor: TaskColor = TaskColor.default
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16.0) {
                HStack {
                    TextField($draftText, placeholder: Text("Create a new task..."))
                        .frame(height: 40)
                        .padding(.horizontal, 8)
                        .border(Color.gray, cornerRadius: 8)
                    Image(systemName: "plus.circle").imageScale(.large)
                        .tapAction {
                            guard !self.draftText.isEmpty else {
                                return
                            }
                            self.taskListViewModel.create(text: self.draftText, color: self.selectedColor)
                            self.clear()
                    }
                }

                HStack {
                    ForEach(TaskColor.allCases.identified(by: \.self)) { c in
                        Image(systemName: c == self.selectedColor ? "circle.fill" : "circle")
                            .foregroundColor(c.color)
                            .tapAction { self.selectedColor = c }
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3), cornerRadius: 8.0)
        .padding(.horizontal)
    }

    private func clear() {
        draftText = ""
        selectedColor = TaskColor.default
    }
}

#if DEBUG
struct CreateTaskView_Previews : PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
#endif
