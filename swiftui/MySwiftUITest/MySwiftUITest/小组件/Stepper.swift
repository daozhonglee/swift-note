//
//  Stepper.swift
//  MySwiftUITest
//
//  Created by shanquan on 2024/12/27.
//

import SwiftUI

struct Stepper: View {
    @State private var amount: Int = 0
    var body: some View {
        //步进器
        Stepper(onIncrement: {
            amount += 1
        }, onDecrement: {
        }) {
            Text("Amount: \(amount)")
        }

    }
}

#Preview {
    Stepper()
}
