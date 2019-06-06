//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import SwiftUI

struct RootView : View {
    @EnvironmentObject private var userData: UserData

    var body: some View {
        switch userData.authState {
        case .initial:
            return AnyView(Color.white)
        case .notAuthenticated:
            return AnyView(SignUpView())
        case let .authenticated(user):
            return AnyView(TaskListView().environmentObject(TaskListViewModel(user: user)))
        }
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
