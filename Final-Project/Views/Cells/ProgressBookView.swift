//
//  ProgressView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 20/09/24.
//

import SwiftUI

struct ProgressBookView: View {
    let bookItem: BookItem
    let screenWidth = UIScreen.main.bounds.width
    @State var selectedCategory: String = "Add book"
    let currentPage: Int
    @ObservedObject var viewModel: ReadingViewModel

    
    
    var body: some View {
        ScrollView {
            
            VStack (spacing: 4){
                SearchImageCell(url: bookItem.volumeInfo.imageLinks?.smallThumbnail)
                    .frame(width: 170, height: 240)
                    .padding()
                Text(bookItem.volumeInfo.title)
                    .frame(width: screenWidth * 0.80, alignment: .center)
                    .lineLimit(nil) // Allow the text to wrap into multiple lines
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                Text("by \(bookItem.volumeInfo.authors?.joined(separator: ", ") ?? "")")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.secondary)
                    .padding(.bottom, 30)
                VStack {
                    Menu {
                        
                        Button("To read") {
                            updateCategory(to: "toRead")
                        }
                        Button("Reading") {
                            updateCategory(to: "reading")
                        }
                        Button("Read") {
                            updateCategory(to: "read")
                        }
                        
                    } label: {
                        
                        Label(mapCategoryToLabel(selectedCategory), systemImage: categoryIcon(for: selectedCategory))
                    }
                    .padding()
                    .frame(width: 200)
                    .background(Color.gray.opacity(0.1))
                    .foregroundStyle(Color.brandPrimary)
                    .cornerRadius(20)
//                    if selectedCategory == "reading" {
                        if let pageCount = bookItem.volumeInfo.pageCount {
                            ProgressView(value: Float(currentPage), total: Float(pageCount)) {
                            } currentValueLabel: {
                                Text(String(format: "%.0f%%", viewModel.percentage))
                                    .font(.title3)
                                    .padding(.top, 7)// Display as an integer percentage (e.g., 50%)
                            }
                            .padding()
                            .tint(.brandPrimary)
                            Text("\(currentPage) of \(pageCount) pages")
                                .frame(width: screenWidth/2)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.pink))
                        }
                                            
                       
                        
                    HStack {
                        Text("Update progress: ")
                            .frame(maxWidth: .infinity)
                            .font(.title3)
                            .fontWeight(.semibold)
                            
                        TextField("Current Page", text: $viewModel.progress, onCommit: {
                            viewModel.updateProgress()
                        })
                        .frame(width: screenWidth/3)
                        .font(.system(size: 18)) // Font size and weight
                        .foregroundColor(.pink) // Text color
                        .padding()
                        .background(Color.gray.opacity(0.1)) // Background color for the text
                        .cornerRadius(20) // Rounded corners for the background
                        .padding(.horizontal)
                    }
                        
                        
                    }
//                }
                .onAppear {
                    fetchCategoryForBook()
                }
            }
            Divider()
                .padding()
//            Text("Description")
//                .font(.title3)
//                .fontWeight(.semibold)
//                .padding(.bottom, 8)
//            Text(bookItem.volumeInfo.description ?? "")
//                .padding(.horizontal)
//                .font(.body)
//                .foregroundStyle(Color.secondary)
        }
    }
    private func updateCategory(to category: String) {
        selectedCategory = category
        BooksManager.shared.updateBookDictionary(to: category, bookID: bookItem.id)
    }
    
    // Fetch the category from Firestore when the view appears
    private func fetchCategoryForBook() {
        BooksManager.shared.fetchBookCategory(bookID: bookItem.id) { category in
            selectedCategory = category ?? "Add book"
        }
    }
    private func mapCategoryToLabel(_ category: String) -> String {
        switch category {
        case "toRead":
            return "To read"
        case "reading":
            return "Reading"
        case "read":
            return "Read"
        default:
            return "Add book"
        }
    }
    private func categoryIcon(for category: String) -> String {
        switch category {
        case "toRead":
            return "arrow.right.circle"
        case "reading":
            return "book"
        case "read":
            return "checkmark"
        default:
            return "chevron.down"
        }
    }
    
}

#Preview {
    ProgressBookView(bookItem: MockData.mockBook1, currentPage: 50, viewModel: ReadingViewModel())
}


