//
//  ContentView.swift
//  MySwiftUITest
//
//  Created by shanquan on 2024/12/26.
//

import SwiftUI

struct BindTestView2: View {
    @State private var count = 0

    var body: some View {
        VStack {
            BindTestViewChild2(number: count)
            Button("+") {
                count += 1
            }
            .font(.largeTitle)
        }
        .padding()
    }
}

struct BindTestViewChild2: View {
    let number:Int

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.blue)
                .frame(width: 100, height: 100)
                .overlay(Text("\(number)")
                            .foregroundColor(.white)
                            .font(.title))
        }
        .padding()
    }
}

#Preview {
    BindTestView2()
}
