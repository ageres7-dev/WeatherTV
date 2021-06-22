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

//    @Binding var text: String
//
//        init(text: Binding<String>) {
//            self._text = text
//        }
//
//    
    
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
        
        //        if state.text == "" {
        let vc = searchContainer.children.first as? UISearchContainerViewController
        
        if isCleanText {
            vc?.searchController.searchBar.text = nil
            isCleanText.toggle()
        }
        print(vc?.searchController.searchBar.text ?? "------")
        //        }
        
        //        searchContainer.
        //         Add horizontal constraint uiKBfv.left = super.left - 90 to
        //         searchContainer.children[0] as? UISearchContainerViewController?.searchController.view.constraints
            
        
        
        
//        if searchContainer.children.count > 0,
//           let searchController = (searchContainer.children[0] as? UISearchContainerViewController)?.searchController,
//           let searchControllerView = searchController.view,
//           searchController.children.count > 1,
//           let uiKBFocusView = searchController.children[1].view,
//           !searchControllerView.constraints.reduce(false, {$0 || ($1.firstAttribute == NSLayoutConstraint.Attribute.centerX) }){
//
//            let horizontalConstraint = NSLayoutConstraint(item: uiKBFocusView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: searchControllerView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
//
//            searchControllerView.addConstraints([horizontalConstraint])
//            
//        }
         
    }
}
