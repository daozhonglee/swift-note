//
//  ContentView.swift
//  MySwiftUITest
//
//  Created by shanquan on 2024/12/26.
//

import SwiftUI

struct BindTestView3: View {
    @State private var count = 0

    var body: some View {
        VStack {
            BindTestViewChild3(count:  count)
            .font(.largeTitle)
        }
        .padding()
    }
}

struct BindTestViewChild3: View {
    @State var count:Int

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.blue)
                .frame(width: 100, height: 100)
                .overlay(Text("\(count)")
                            .foregroundColor(.white)
                            .font(.title))
            Button("+") {
                count += 1
            }
        }
        .padding()
    }
}

#Preview {
    BindTestView3()
}
