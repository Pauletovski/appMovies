//
//  FilterDate.swift
//  movies-test
//
//  Created by Paulo Lazarini on 30/01/23.
//

import SwiftUI
import Combine

struct FilterDate: View {
    
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
                Text("Date")
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
            ForEach(2000...2023, id: \.self) { date in
                Button {
                    viewModel.onlyFavoriteMovies.filter { movie in
                        return movie.release_date.contains(String(date))
                    }.forEach { movie in
                        viewModel.dateMovieList.append(movie)
                    }
                    coordinator.presentFavoriteMovie()
                    print(viewModel.dateMovieList)
                    viewModel.hasFilter = true
                    viewModel.onlyFavoriteMovies = viewModel.dateMovieList
                } label: {
                    Text(String(date))
                }
                
            }
        }
        .padding(.top, -30)
        .listStyle(.inset)
        .foregroundColor(.black)
    }
}


struct FilterDate_Previews: PreviewProvider {
    static var previews: some View {
        FilterDate(viewModel: MainViewModel(networkProvider: NetworkManager()), coordinator: Coordinator(navigationController: UINavigationController()))
    }
}
