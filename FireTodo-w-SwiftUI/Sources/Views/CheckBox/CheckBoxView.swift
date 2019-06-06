//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import SwiftUI

struct CheckBoxView : View {
    var isChecked: Bool
    var action: () -> Void
    var body: some View {
        Image(systemName: self.isChecked ? "checkmark.square.fill" :  "checkmark.square")
            .imageScale(.large)
            .tapAction(self.action)
    }
}

#if DEBUG
struct CheckBoxView_Previews : PreviewProvider {
    static var previews: some View {
        CheckBoxView(isChecked: false, action: {})
    }
}
#endif
