//
//  MainViewModel.swift
//  movies-test
//
//  Created by Paulo Lazarini on 28/12/22.
//

import Foundation
import Combine
import SwiftUI
//import Moya

class MainViewModel: ObservableObject {

    let movieSearched = PassthroughSubject<String, Never>()
    let searchTextSubject = PassthroughSubject<String, Never>()
    var cancelSet = Set<AnyCancellable>()
    let networkProvider: Networkable
    
    init(networkProvider: Networkable) {
        self.networkProvider = networkProvider
        
        getNewMovies()
        getResultMovies()
        getFavoriteMovies()
        getResultMoviesFavorite()
        getText()
    
    }
    
    @Published var movieSearchedResult: [MainViewData.MovieViewData] = []
    @Published var movieSearchedResultFavorite: [MainViewData.MovieViewData] = []
    @Published var moviesViewData: [MainViewData.MovieViewData] = []
    @Published var onlyFavoriteMovies: [MainViewData.MovieViewData] = []
    @Published var searchText = ""
    
    func getNewMovies() {
        networkProvider.getNewMovies(page: 1) { movies in
            self.moviesViewData = []
            movies.forEach { Movie in
                self.moviesViewData.append(MainViewData.MovieViewData(title: Movie.title, id: Movie.id, poster_path: Movie.poster_path, overview: Movie.overview, release_date: Movie.release_date, favorite: false))
            }
        }
    }
    
    func getFavoriteMovies() {
        
        var favoriteMovies: [MainViewData.MovieViewData] = []
        
        self.moviesViewData.forEach { movie in
            if movie.favorite == true {
                favoriteMovies.append(movie)
            }
        }
        onlyFavoriteMovies = favoriteMovies
    }
    
    func getResultMovies() {
        movieSearched
            .sink { [weak self] title in
            guard let self else { return }
            self.moviesViewData.forEach { movie in
                if movie.title == title {
                    self.movieSearchedResult.append(movie)
                }
            }
        }.store(in: &cancelSet)
    }
    
    func getResultMoviesFavorite() {
        movieSearched
            .sink { [weak self] title in
            guard let self else { return }
            self.onlyFavoriteMovies.forEach { movie in
                if movie.title == title {
                    self.movieSearchedResultFavorite.append(movie)
                }
            }
        }.store(in: &cancelSet)
    }
    
    func getText() {
        searchTextSubject
            .sink { [weak self] text in
            guard let self = self else { return }
            self.searchText = text
            }.store(in: &cancelSet)
    }
    
    func buildMovieCard(index: Int) -> some View {
        let view = MovieCard(
            text: moviesViewData[index].title,
            image: moviesViewData[index].poster_path,
            id: moviesViewData[index].id,
            releaseDate: moviesViewData[index].release_date,
            overview: moviesViewData[index].overview,
            isFavorite: moviesViewData[index].favorite
        )

        
        view.toggleFavorite.sink { value in
            self.moviesViewData[index].favorite = value
        }
        .store(in: &cancelSet)
        
        return view
            .aspectRatio(2/3, contentMode: .fill)
    }
    
    func buildFavoriteMovies(index: Int) -> some View {
        let view = MovieCard(
            text: onlyFavoriteMovies[index].title,
            image: onlyFavoriteMovies[index].poster_path,
            id: onlyFavoriteMovies[index].id,
            releaseDate: onlyFavoriteMovies[index].release_date,
            overview: onlyFavoriteMovies[index].overview,
            isFavorite: onlyFavoriteMovies[index].favorite
        )
        
        view.toggleFavorite.sink { value in
            self.onlyFavoriteMovies[index].favorite = value
        }
        .store(in: &cancelSet)
        
        return view
            .aspectRatio(2/3, contentMode: .fill)
    }
    
    func buildResultMovies(index: Int) -> some View {
        let view = MovieCard(
            text: movieSearchedResult[index].title,
            image: movieSearchedResult[index].poster_path,
            id: movieSearchedResult[index].id,
            releaseDate: movieSearchedResult[index].release_date,
            overview: movieSearchedResult[index].overview,
            isFavorite: movieSearchedResult[index].favorite
        )
        
        view.toggleFavorite.sink { value in
            self.movieSearchedResult[index].favorite = value
        }
        .store(in: &cancelSet)
        
        return view
            .aspectRatio(2/3, contentMode: .fill)
    }
    
    func buildResultFavoriteMovies(index: Int) -> some View {
        let view = MovieCard(
            text: movieSearchedResultFavorite[index].title,
            image: movieSearchedResultFavorite[index].poster_path,
            id: movieSearchedResultFavorite[index].id,
            releaseDate: movieSearchedResultFavorite[index].release_date,
            overview: movieSearchedResultFavorite[index].overview,
            isFavorite: movieSearchedResultFavorite[index].favorite
        )
        
        view.toggleFavorite.sink { value in
            self.movieSearchedResultFavorite[index].favorite = value
        }
        .store(in: &cancelSet)
        
        return view
            .aspectRatio(2/3, contentMode: .fill)
    }
    
}
