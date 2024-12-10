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
            debugPrint(
                "column: \(columnCount), count: \(count), rowCount: \(rowCount)"
            )
            if rowCount * height < size.height {
                debugPrint("bb: \(columnCount)")
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(
            .down)
    }

}
