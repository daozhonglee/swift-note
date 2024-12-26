//
//  ContentView.swift
//  MySwiftUITest
//
//  Created by shanquan on 2024/12/26.
//

import SwiftUI

struct BindTestView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.blue)
                .frame(width: 100, height: 100)
                .overlay(Text("\(count)")
                            .foregroundColor(.white)
                            .font(.title))
            Button("Increment") {
                count += 1
            }
        }
        .padding()
    }
}

struct BindTestViewChild: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    BindTestView()
}
