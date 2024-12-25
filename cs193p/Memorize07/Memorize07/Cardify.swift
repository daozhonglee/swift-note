//
//  Cardify.swift
//  Memorize07
//
//  Created by shanquan on 2024/12/10.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool

    //所有的视图修饰符都是通过这种形式来实现对视图的操作的， 通过body方法来实现对视图的操作
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.fill(.white)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
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
