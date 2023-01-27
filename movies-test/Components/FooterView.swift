//
//  FooterView.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/12/22.
//

import SwiftUI
import Combine

struct FooterView: View {
    
    @ObservedObject var viewModel:MainViewModel
    var coordinator: Coordinator
    @State var presentFavorite: Bool = false

    var body: some View {
        ZStack {
            GeometryReader { reader in
                Color.yellow.opacity(0.6)
            
                HStack(alignment: .bottom) {

                    Button {
                        viewModel.searchText = ""
                        coordinator.start()
                    } label: {
                        VStack {
                            Image(systemName: "popcorn")
                                .font(.system(size: 40))
                            
                            Text("Movies")
                        }
                    }
                    .frame(width: reader.size.width/2, height: reader.size.height)
                    .tint(.black)
                    
                    Button {
                        viewModel.searchText = ""
                        coordinator.presentFavoriteMovie()
                    } label: {
                        VStack {
                            Image(systemName: "heart")
                                .font(.system(size: 45))
                            Text("Favorite")
                        }
                    }
                    .frame(width: reader.size.width/2, height: reader.size.height)
                    .tint(.black)
                }
            }
        }
        .frame(height: 100)
    }
}


