//
//  ContentView.swift
//  PersonalProfile
//
//  Created by shanquan on 2024/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showTogether = false
    @State private var selectedColor: Color = .blue
    @State private var selectedLanguage: String = "简体中文"
    @State private var languages: [String] = ["简体中文","English","日本語","한국어"]


    var body: some View {
        VStack (spacing: 20) {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
////            Image("red_timer")
////                .resizable()
////                .aspectRatio(contentMode: .fit)
//            TextField("Enter your name", text: .constant(""))
//                .textFieldStyle(.roundedBorder)
////            Button("Show Together") {
////                showTogether.toggle()
////                debugPrint(showTogether)
////            }.buttonStyle(.bordered)
////
////            ChildView(showToghther: $showTogether)
//
//            ColorPicker(selection: $selectedColor, label: {
//                Text("Choose a color")
//            })

            Picker(selection: $selectedLanguage, label:
                       HStack {
                           Image(systemName: "waveform")
                               .font(.system(size: 20))
                           Text("系统语言")
                       }
                   ) {
                       ForEach(languages, id: \.self) { language in
                           Text(language)
                       }
                   }





        }
        .padding()
    }
}

struct ChildView:View {
    @Binding var showToghther: Bool
    var body: some View {
        VStack{

        Toggle(isOn: $showToghther, label: {
            Text("Show together")
        })
            Text("Show together: \(showToghther.description)")

        }

    }
}

#Preview {
    ContentView()
}
