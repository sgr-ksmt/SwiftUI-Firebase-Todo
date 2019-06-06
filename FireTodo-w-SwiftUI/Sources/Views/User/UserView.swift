//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import SwiftUI

struct UserView : View {
    @EnvironmentObject private var userData: UserData
    var user: Document<Model.User>! = nil
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 200, height: 200)

            Text(self.user.data.name)
                .font(.largeTitle)

            Button(action: {
                self.userData.signOut()

            }) { Text("Sign Out") }
                .frame(height: 44.0)
                .padding(.horizontal)
                .background(Color.green, cornerRadius: 8.0)
        }
    }
}

#if DEBUG
struct UserView_Previews : PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
#endif
