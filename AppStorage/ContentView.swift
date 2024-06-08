//
//  ContentView.swift
//  AppStorage
//
//  Created by Shinhyuk on 2024/06/05.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("toggle") private var isToggle = false
    
    var body: some View {
        Toggle(isOn: $isToggle) {
            Text("Toggle - \(String(isToggle))")
        }
        .frame(width:300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
