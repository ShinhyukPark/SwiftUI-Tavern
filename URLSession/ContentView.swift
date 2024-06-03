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
        NavigationStack {
            ScrollView{
                ForEach(results) { profile in
                    HStack{
                        AsyncImage(url:URL(string: profile.image)) { item in
                            item.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width:180, height: 180)
                        .clipShape(Circle())
                        VStack(alignment: .leading){
                            Text(profile.name)
                                .font(.headline)
                                .bold()
                            HStack{
                                Circle()
                                    .fill(profile.status == "Alive" ? Color.green : profile.status == "Dead" ? Color.red : Color.gray)
                                    .frame(width:10,height: 10)
                                Text("\(profile.status) - \(profile.species)")
                                    .font(.subheadline)
                            }
                            Text("출생:")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(profile.origin.name)
                                .font(.body)
                            Text("현재 위치:")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(profile.location.name)
                                .font(.body)
                        }
                        .frame(width: 180,alignment: .leading)
                    }
                    .foregroundColor(.white)
                    .background(Color("ProfileBackground"))
                    .cornerRadius(15)
                }
                
            }
            .navigationTitle("URLSession")
            .onAppear(perform: loadData)
        }
    }
    
    
    func loadData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do {
                    let decoder = JSONDecoder()
                    let decodedCharacters = try decoder.decode(Characters.self, from: data)
                    DispatchQueue.main.async {
                        self.results = decodedCharacters.results
                        print("Data loaded successfully: \(self.results)")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
