//
//  AspectVGrid.swift
//  Memorize06
//
//  Created by shanquan on 2024/12/9.

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]

    var aspectRatio: CGFloat = 1.0
    //content 是一个函数，返回一个 view
    var content: (Item) -> ItemView

    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: gridItemSize), spacing: 0)
                ],
                spacing: 0
            ) {
                //当点击 shuffle 时，会重新排列卡片顺序， 这会导致 LazyV 网格重新定位其中的所有视图，
                //当我单击shuffle 时，真正动画的只是 LazyVGrid 实现中 ViewModifier 位置的参数，我们看不到，但所有发生变化的 ViewModifier 仍然会受到影响，因为我们显式地对随用户意图而变化的所有内容进行动画处理。
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)

                }
            }
        }
    }

    //计算最合适的网格宽度
    func gridItemWidthThatFits(
        count: Int, size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio

            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(
            .down)
    }

}
