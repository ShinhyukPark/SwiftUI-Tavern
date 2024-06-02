//
//  ContentView.swift
//  URLSession
//
//  Created by Shinhyuk on 2024/06/01.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results = [Results]()
    
    var body: some View {
        NavigationStack{
            List(results) { result in
                VStack{
                    Text(result.name)
                }
            }
        }
        .navigationTitle("URLSession")
        .onAppear(perform: loadData)
    }
}
func loadData(){
    guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
        print("Invalid URL")
        return
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
