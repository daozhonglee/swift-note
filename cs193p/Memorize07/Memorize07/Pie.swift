//
//  Pie.swift
//  Memorize07
//
//  Created by shanquan on 2024/12/9.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    let startAngle: Angle = .zero
    let endAngle: Angle
    var clockwise: Bool = false

    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(-90)
        let endAngle = endAngle - .degrees(-90)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        // 计算起始点
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )

        var p = Path()
        //移动到圆心
        p.move(to: center)
        //增加直线部分
        p.addLine(to: start)
        //增加弧线部分
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        p.addLine(to: center  )

        return p

    }

}
