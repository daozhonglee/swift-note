//
//  Cardify.swift
//  Memorize07
//
//  Created by shanquan on 2024/12/10.
//
// cardify 用于把一个输入的内容，变成一个 card 的样式

import SwiftUI


struct Cardify: ViewModifier, Animatable{

    //这里增加这个 init 是为了解决增加 rotation 之后， 预览中报错的问题，因为增加了 rotation 之后， 会自动增加一个 init 方法， 但是这个方法是没有参数的， 所以这里需要增加一个 init 方法， 以便解决这个问题
    //这里是想说，当反转角度大于 90 度的时候，才展示正面的图像，否则不展示（不想在还没完全转过来的时候，就让玩家看到图像）
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

    //所有的视图修饰符都是通过这种形式来实现对视图的操作的， 通过body方法来实现对视图的操作
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.fill(.white)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
            //我们不希望卡片的不透明度被动画化。希望它在达到 90 度时立即发生。 除了让视图修改器本身控制动画之外，没有其他办法可以做到这一点。
            //它必须参与该旋转的每个分段转动，以便在从不透明度切换时可以使不透明度正确。在这里边缘。
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        //3D 旋转, axis 是围绕哪个轴转
//        .rotation3DEffect(.degrees(isFaceUp ? 0 : 180), axis: (0, 1, 0))
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
