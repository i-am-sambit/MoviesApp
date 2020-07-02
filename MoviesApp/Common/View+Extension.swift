//
//  View+Extension.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 14/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation
import SwiftUI

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

extension View {
    func preview(device: PreviewDevice.Device, displayMode: ColorScheme = .light) -> some View {
        self
            .previewDevice(.init(rawValue: device.rawValue))
            .previewDisplayName(device.rawValue)
            .environment(\.colorScheme, displayMode)
    }
}
