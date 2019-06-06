//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import SwiftUI

enum TaskColor: String, CaseIterable {
    case red
    case green
    case blue
    case yellow

    var color: Color {
        switch self {
        case .red: return .red
        case .green: return .green
        case .blue: return .blue
        case .yellow: return .yellow
        }
    }

    static var `default`: TaskColor {
        return .red
    }

    static var random: TaskColor {
        return TaskColor.allCases.randomElement()!
    }
}
