//
//  Not Found.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/01/23.
//

import SwiftUI

struct NotFound: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 120))
                .bold()
                .imageScale(.large)
                .foregroundColor(.black)
            
            Text("Sua busta por '\(viewModel.searchText)' não encontrou nenhum resultado.")
                .font(.system(size: 25))
                .padding(.horizontal, 30)
                .bold()
        }
    }
}

struct Not_Found_Previews: PreviewProvider {
    static var previews: some View {
        NotFound(viewModel: MainViewModel(networkProvider: NetworkManager()))
    }
}
