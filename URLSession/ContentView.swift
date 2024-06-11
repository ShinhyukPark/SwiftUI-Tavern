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
            print("Invalid URL") //URL객체를 생성, URL이 유효한지 확인
            return
        }
        //네트워크 요청
        URLSession.shared.dataTask(with: url) { data, response, error in //dtaTask구조? 데이터, 응답, 오류
            if let data = data{
                do {
                    //디코딩
                    let decoder = JSONDecoder()
                    let decodedCharacters = try decoder.decode(Characters.self, from: data)
                    //메인 스레드에서 비동기적으로 작업?, 디코딩 된 데이터를 results에 저장
                    DispatchQueue.main.async {
                        self.results = decodedCharacters.results
                        print("Data loaded successfully: \(self.results)")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        //dataTask는 기본적으로 정지상태, 요청시작
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
