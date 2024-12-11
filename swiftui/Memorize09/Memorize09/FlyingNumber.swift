//
//  FlyingNumber.swift
//  Memorize08
//
//  Created by shanquan on 2024/12/11.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int

    var body: some View {
        if number != 0{
            Text(number, format: .number)
                .transition(.offset(x: 0, y: -100))
        }
    }
}

#Preview {
    FlyingNumber(number:5)
}
