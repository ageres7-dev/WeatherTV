//
//  SearchWrapper.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 30.05.2021.
//

import SwiftUI


// MARK: - Search

class SearchState: NSObject, ObservableObject, UISearchResultsUpdating {
    @Published var text: String = ""
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        text = searchBar.text ?? ""
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
        searchController.searchBar.placeholder = NSLocalizedString("Enter city", comment: "")
        
        // Contain the `UISearchController` in a `UISearchContainerViewController`.
        let searchContainer = UISearchContainerViewController(searchController: searchController)
        searchContainer.title = NSLocalizedString("City search", comment: "")

        // Finally contain the `UISearchContainerViewController` in a `UINavigationController`.
        let searchNavigationController = UINavigationController(rootViewController: searchContainer)

        return searchNavigationController
    }
    
    func updateUIViewController(_ searchContainer: UINavigationController, context: Context) {
        print("Update Page Search Controller")
    
        let vc = searchContainer.children.first as? UISearchContainerViewController
        
        if isCleanText {
            vc?.searchController.searchBar.text = nil
            isCleanText.toggle()
        }
    }
}
