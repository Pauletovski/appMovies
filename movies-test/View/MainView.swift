//
//  ContentView.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/12/22.
//

import SwiftUI
import UIKit

class MainViewData {
    
    let movies: [MovieViewData]? = nil
    
    struct MovieViewData: Equatable, Identifiable {
        var title: String
        var id: Int
        var poster_path: String
        var overview: String
        var release_date: String
        var favorite: Bool
        var genre_ids: [Int]
        
        init(title: String, id: Int, poster_path: String, overview: String, release_date: String, favorite: Bool, genre_ids: [Int]) {
            self.title = title
            self.id = id
            self.poster_path = poster_path
            self.overview = overview
            self.release_date = release_date
            self.favorite = favorite
            self.genre_ids = genre_ids
        }
    }
}

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @State var searchText: String = ""
    var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(viewModel: viewModel, searchText: searchText, title: "Movies")
                
                Spacer()
                
                if viewModel.error {
                    ErrorOcurred()
                } else {
                    if viewModel.movieSearchedResult.isEmpty {
                        if viewModel.searchText == "" {
                            MovieGridView(viewModel: viewModel)
                        } else {
                            NotFound(viewModel: viewModel)
                        }
                    } else {
                        ResultMovieGridView(viewModel: viewModel)
                    }
                }
                
                Spacer()
                

                
                FooterView(viewModel: viewModel, coordinator: coordinator)
            }
        }.onAppear {
            self.viewModel.movieSearchedResult = []
            self.viewModel.movieSearchedResultFavorite = []
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(networkProvider: NetworkManager()), coordinator: Coordinator(navigationController: UINavigationController()))
    }
}
