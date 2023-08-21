//
//  DetailScreenInfo.swift
//  RickAndMorty
//
//  Created by Sergey Kykhov on 18.08.2023.
//

import Foundation
import SwiftUI
import Kingfisher


struct DetailScreenInfo: View {
    
    // MARK: - Properties and Initializer
    @State private var episodes: [ModelEpisodesRepresentable] = []
    @State private var locations: ModelLocationsRepresentable = .init(name: "", type: "")
    @State private var isLoading: Bool = true
    
    let columns = [GridItem(.flexible())]
    let character: CharactersModelElement
    
    init(character: CharactersModelElement) {
        self.character = character
    }

    // MARK: - Methods
    func formatEpisode(_ episode: String) -> String {
        let components = episode.split(separator: "E")
        if components.count == 2,
           let seasonNumber = Int(components[0].dropFirst(1)),
           let episodeNumber = Int(components[1]) {
            return "Episode: \(episodeNumber), Season: \(seasonNumber)"
        }
        return episode
    }
    
    //MARK: - Body
    var body: some View {

    //MARK: - Loader
        ZStack {
            Color(red: 0.013, green: 0.048, blue: 0.119).edgesIgnoringSafeArea(.all)
            Image("Stars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
            } else {

    //MARK: - ElementsUI
                ScrollView(.vertical) {
                    LazyVStack(alignment: .center) {

                        Spacer(minLength: 16)

                        // Профиль изображения
                        KFImage(URL(string: character.image)).resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.horizontal, 81.0)
                            .frame(width: 148, height: 148)
                            .cornerRadius(10)

                        Spacer(minLength: 24)

                        // Имя персонажа
                        Text(character.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .padding(.horizontal)

                        Spacer(minLength: 8)

                        // Статус персонажа
                        Text(character.status)
                            .font(.system(size: 16))
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .padding(.horizontal)

                        Spacer(minLength: 24)

                        // Информация о персонаже
                        LazyVGrid(columns: columns, alignment: .leading) {
                            Section(header: Text("Info").font(.system(size: 17)).bold().foregroundColor(.white)) {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(15)
                                        .frame(height: 120)
                                        .foregroundColor(Color(red: 0.15, green: 0.165, blue: 0.22))
                                    VStack(spacing: 16) {
                                        HStack {
                                            Text("Species:")
                                                .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                                .font(.system(size: 16))
                                            Spacer()
                                            Text(character.species)
                                                .foregroundColor(.white)
                                                .font(.system(size: 16))
                                        }
                                        HStack {
                                            Text("Type:")
                                                .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                                .font(.system(size: 16))
                                            Spacer()
                                            Text(character.type == "" ? "None" : character.type)
                                                .foregroundColor(.white)
                                                .font(.system(size: 16))
                                        }
                                        HStack {
                                            Text("Gender:")
                                                .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                                .font(.system(size: 16))
                                            Spacer()
                                            Text(character.gender)
                                                .foregroundColor(.white)
                                                .font(.system(size: 16))
                                        }
                                    }
                                    .padding()
                                }
                            }

                            // Локация персонажа
                            Section(header: Text("Origin").font(.system(size: 17)).bold().foregroundColor(.white).padding(.top, 15)) {
                                ZStack(){
                                    Rectangle()
                                        .cornerRadius(15)
                                        .frame(height: 80)
                                        .foregroundColor(Color(red: 0.15, green: 0.165, blue: 0.22))
                                    HStack {
                                        ZStack {
                                            Rectangle()
                                                .cornerRadius(10)
                                                .foregroundColor(Color(red: 0.095, green: 0.11, blue: 0.165))
                                                .frame(width: 64, height: 64)
                                            Image("Planet")
                                                .frame(width: 24, height: 24)
                                        }
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(locations.name)
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                                .font(.system(size: 16))
                                            Text(locations.type)
                                                .foregroundColor(.green)
                                                .font(.system(size: 13))
                                        }
                                        .padding(.leading, 10)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(8)
                                }
                            }

                            // Эпизоды с персонажем
                            Section(header: Text("Episodes").font(.system(size: 17)).bold().foregroundColor(.white).padding(.top, 15)) {
                                ForEach(episodes, id: \.id) { episode in
                                    ZStack {
                                        Rectangle()
                                            .cornerRadius(15)
                                            .frame(height: 86)
                                            .foregroundColor(Color(red: 0.15, green: 0.165, blue: 0.22))
                                        LazyVStack(spacing: 20) {
                                            Text(episode.name)
                                                .foregroundColor(.white)
                                                .font(.system(size: 16))
                                                .bold()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            HStack(){
                                                Text(formatEpisode(episode.episode))
                                                    .foregroundColor(.green)
                                                    .font(.system(size: 13))
                                                Spacer()
                                                Text(episode.air_date)
                                                    .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                                    .font(.system(size: 12))
                                            }
                                        }
                                        .padding()
                                    }
                                    .padding(.bottom ,10)
                                }
                            }
                        }
                        .padding([.leading, .trailing], 15)
                    }
                }
                .background(Color(red: 0.013, green: 0.048, blue: 0.119))
            }
        }

        //MARK: - Appear
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //проверка loader, задержка подгрузки данных на 1 сек.)
                isLoading = false
                var result = ""
                for episode in character.episode {
                    let separated = episode.components(separatedBy: "/")
                    let episodeNumber = separated.last ?? ""
                    result += episodeNumber
                    if episode != character.episode.last {
                        result += ","
                    }
                }
                
                NetworkManager.shared.makeRequst(url: Constants.episodeUrl, params: result) { (result: [ModelEpisodesRepresentable]) in
                    self.episodes = result
                }
                
                NetworkManager.shared.makeRequst(url: character.location.url, params: "") { (result: ModelLocationsRepresentable) in
                    self.locations = result
                }
            }
        }
    }
} //finish struct

struct DetailScreenInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenInfo(character: .init(id: 1, name: "Name", status: "Alive", species: "Human", type: "None", gender: "Male", origin: .init(name: "", url: "1"), location: .init(name: "1", url: "1"), image: "Planet", episode: [""], url: "", created: ""))
    }
}



