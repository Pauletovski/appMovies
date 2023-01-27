//
//  MovieView.swift
//  movies-test
//
//  Created by Paulo Lazarini on 29/12/22.
//

import SwiftUI
import NukeUI

struct BottomSheet: View {
    
    let image: String
    let title: String
    let id: Int
    let overview: String
    let releaseDate: String
    
    var body: some View {
        VStack(spacing: .zero) {
            
            LazyImage(source: URL(string: "https://image.tmdb.org/t/p/w500\(image)"))
            
            VStack(spacing: 15) {
                
                Text(title)
                
                Divider()
                
                Text(overview)
                
                Divider()
                
                Text(releaseDate)
            }
            .padding(20)
            .foregroundColor(.black)
            .bold()
            .background(Color.yellow.opacity(0.6))
        }
        .ignoresSafeArea()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(image: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg", title: "Avatar: The Way of Water", id: 0, overview: "Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.", releaseDate: "2022-12-14")
    }
}
