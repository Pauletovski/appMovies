//
//  FilterGenre.swift
//  movies-test
//
//  Created by Paulo Lazarini on 30/01/23.
//


import SwiftUI
import Combine

struct FilterGenre: View {
    
    @ObservedObject var viewModel: MainViewModel
    var coordinator: Coordinator
    
    var body: some View {
        VStack {
            buildHeader()
            
            Spacer()
            
            buildBody()
        }
        .ignoresSafeArea()
    }
    
    
    func buildHeader() -> some View {
        ZStack {
            HStack {
                Button {
                    coordinator.presentFilter()
                } label: {
                    Image(systemName: "chevron.backward")
                        .padding(.top, 30)
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
                    
                    Spacer()
                }
            }
            
            HStack {
                
                Spacer()
                Text("Genre")
                    .foregroundColor(.black)
                    .font(.title2)
                    .padding(.top, 30)
                    .padding()
                Spacer()
                
            }
        }
        .background(Color.yellow.opacity(0.5))
        .frame(height: 150)
    }
    
    
    
    
    func buildBody() -> some View {
        List {
            ForEach(viewModel.genreList) { genre in
                Button {
                    viewModel.onlyFavoriteMovies.filter { genreMovie in
                        return genreMovie.genre_ids.contains(genre.id)
                    }.forEach { genreMovie in
                        viewModel.genreMovieList.append(genreMovie)
                    }
                    coordinator.presentFavoriteMovie()
                    print(viewModel.genreMovieList)
                    viewModel.hasFilter = true
                    viewModel.onlyFavoriteMovies = viewModel.genreMovieList
                } label: {
                    Text(genre.name)
                    
                }
                
            }
        }
        .padding(.top, -30)
        .listStyle(.inset)
        .foregroundColor(.black)
    }
}

struct FilterGenre_Previews: PreviewProvider {
    static var previews: some View {
        FilterGenre(viewModel: MainViewModel(networkProvider: NetworkManager()), coordinator: Coordinator(navigationController: UINavigationController()))
    }
}
