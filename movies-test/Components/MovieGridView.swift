//
//  MovieViewGrid.swift
//  movies-test
//
//  Created by Paulo Lazarini on 29/12/22.
//

import SwiftUI
import Combine

struct MovieGridView: View {
    
    @ObservedObject var viewModel:MainViewModel
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(0..<viewModel.moviesViewData.count, id: \.self) { index in
                    viewModel.buildMovieCard(index: index)
                }
            }            
        }
        .padding(.horizontal, 8)
    }
}

struct FavoriteMovieGridView: View {
    
    @ObservedObject var viewModel:MainViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(0..<viewModel.onlyFavoriteMovies.count, id: \.self) { index in
                    viewModel.buildFavoriteMovies(index: index)
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

struct ResultMovieGridView: View {
    
    @ObservedObject var viewModel:MainViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(0..<viewModel.movieSearchedResult.count, id: \.self) { index in
                    viewModel.buildResultMovies(index: index)
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

struct ResultFavoriteMovieGridView: View {
    
    @ObservedObject var viewModel:MainViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(0..<viewModel.movieSearchedResultFavorite.count, id: \.self) { index in
                    viewModel.buildResultFavoriteMovies(index: index)
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

