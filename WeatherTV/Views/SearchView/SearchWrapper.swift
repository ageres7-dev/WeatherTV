//
//  SearchWrapper.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 30.05.2021.
//

import SwiftUI

@MainActor
class SearchState: NSObject, ObservableObject, UISearchResultsUpdating {
    @Published var text: String = ""
    
    func updateSearchResults(for searchController: UISearchController) {
        Task { @MainActor in
            text = searchController.searchBar.text ?? ""
        }
    }
}

struct SearchWrapper<Page: View>: View {
    var viewController: UIHostingController<Page>
    @ObservedObject var state: SearchState
    @Binding var isCleanText: Bool

    init(_ resultsView: Page, state: SearchState, isCleanText: Binding<Bool>) {
        self.viewController = UIHostingController(rootView: resultsView)
        self.state = state
        self._isCleanText = isCleanText
    }
    var body: some View {
        PageViewController(controller: viewController, state: state, isCleanText: $isCleanText)
            .ignoresSafeArea(.all, edges: .all)
    }
}

struct PageViewController: UIViewControllerRepresentable {
    var controller: UIViewController
    @ObservedObject var state: SearchState
    @Binding var isCleanText: Bool
    
    func makeUIViewController(context: Context) -> UINavigationController {
        
        let searchController = UISearchController(searchResultsController: controller)
        searchController.searchResultsUpdater = state
        searchController.searchBar.placeholder = "Enter city".localized()
        
        let searchContainer = UISearchContainerViewController(searchController: searchController)
        searchContainer.title = "City search".localized()

        let searchNavigationController = UINavigationController(rootViewController: searchContainer)

        return searchNavigationController
    }
    
    func updateUIViewController(_ searchContainer: UINavigationController, context: Context) {
        let vc = searchContainer.children.first as? UISearchContainerViewController
        
        if isCleanText {
            vc?.searchController.searchBar.text = nil
            isCleanText.toggle()
        }
    }
}
