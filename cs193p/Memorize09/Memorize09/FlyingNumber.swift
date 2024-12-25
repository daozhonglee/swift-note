//
//  FlyingNumber.swift
//  Memorize08
//
//  Created by shanquan on 2024/12/11.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int

    //在 iOS 中，减号意味着向上，因为我们的坐标系是颠倒的。
    @State private var offset: CGFloat = 0

    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                // .offset 很好，它是相对偏移量
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                // 当出现字母的时候，就开始动画
                .onAppear{
                    withAnimation(.easeInOut(duration: 1)) {
                        offset = number < 0 ? 200 : -200
                    }
                }
                //消失的时候，需要重置 offset，否则只会出现一次数字
                .onDisappear{
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
