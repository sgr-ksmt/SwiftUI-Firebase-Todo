//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import SwiftUI

struct SignUpView : View {
    @EnvironmentObject private var userData: UserData
    @State private var name: String = ""
    private var canSignUp: Bool {
        return !name.isEmpty
    }
    var body: some View {
        VStack(spacing: 16.0) {
            Text("Sign Up")
                .font(.largeTitle)
                .edgesIgnoringSafeArea(.top)
                .offset(x: 0, y: -100)

            VStack(alignment: .leading, spacing: 8.0) {
                Text("Name")
                    .font(.subheadline)
                    .underline()

                TextField($name, placeholder: Text("Input your name..."))
                    .frame(height: 40)
                    .padding(.horizontal, 8.0)
                    .border(Color.gray, cornerRadius: 8)
            }
                .padding(.horizontal, 16.0)

            Button(action: {
                self.userData.signIn(with: self.name)
            }) {
                Text("Sign Up").foregroundColor(Color.black.opacity(canSignUp ? 1.0 : 0.25))
            }
                .disabled(!canSignUp)
                .frame(height: 44.0)
                .padding(.horizontal)
                .background(Color.green, cornerRadius: 8.0)
        }
    }
}

#if DEBUG
struct SignUpView_Previews : PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
#endif
