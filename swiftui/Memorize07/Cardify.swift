//
//  Cardify.swift
//  Memorize07
//
//  Created by shanquan on 2024/12/10.
//

import SwiftUI

struct Cardify: ViewModifier{
    var isFaceUp: Bool

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)

                Path{ p in
                    p.move(to: .zero)
                    p.addLine(to: CGPoint(x: 50, y: 80))
                }
                .stroke(lineWidth: 2)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
    }
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}
