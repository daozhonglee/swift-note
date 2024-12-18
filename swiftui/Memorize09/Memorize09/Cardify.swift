//
//  Cardify.swift
//  Memorize07
//
//  Created by shanquan on 2024/12/10.
//
// cardify 用于把一个输入的内容，变成一个 card 的样式

import SwiftUI


struct Cardify: ViewModifier, Animatable{
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    var isFaceUp: Bool{
        rotation < 90
    }

    var rotation: Double
    var animatableData: Double{
        get { return rotation}
        set { rotation = newValue }
    }

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.fill(.white)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
