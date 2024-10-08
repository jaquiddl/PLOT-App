//
//  SearchBar.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 25/07/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchTerm: String

    var body: some View {
        HStack {
            Image(systemName: "sparkle.magnifyingglass")
                .font(.system(size: 30))
                .imageScale(.small)
                .frame(width: 40, height: 40)
                .foregroundColor(.secondary)
            TextField("Title, Author", text: $searchTerm)
                .font(.system(size: 18))
                .foregroundColor(.secondary)
        }
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .padding(.top, 2)
        .padding(.horizontal)
    }
}


