//
//  ErrorOcurred.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/01/23.
//

import SwiftUI

struct ErrorOcurred: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Circle()
                .frame(width: 180, height: 180)
                .foregroundColor(.red)
                .overlay {
                    Image(systemName: "xmark")
                        .font(.system(size: 80))
                        .bold()
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
            
            Text("Um erro ocorreu. Por favor, tente novamente.")
                .font(.system(size: 25))
                .padding(.horizontal, 30)
                .bold()
        }
    }
}
