//
//  ContentView.swift
//  Navigation
//
//  Created by shanquan on 2024/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        NavigationView {
            NavigationLink(destination: Text("Detail View")) {
                Text("Navigate")
            }
            NavigationLink(destination: Text("Detail View")) {
                Text("Navigate")
            }
        }
    }
}

#Preview {
    ContentView()
}
