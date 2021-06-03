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

    init(_ resultsView: Page, state: SearchState) {
        self.viewController = UIHostingController(rootView: resultsView)
        self.state = state
    }
    var body: some View {
        PageViewController(controller: viewController, state: state)
            .ignoresSafeArea(.all, edges: .all)
    }
}

struct PageViewController: UIViewControllerRepresentable {
    var controller: UIViewController
    @ObservedObject var state: SearchState

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
//        print("Update Page Search Controller")
        
        // Add horizontal constraint uiKBfv.left = super.left - 90 to
        // searchContainer.children[0] as? UISearchContainerViewController)?.searchController.view.constraints
            
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

//struct SearchWrapper_: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct SearchWrapper__Previews: PreviewProvider {
//    static var previews: some View {
//        SearchWrapper_()
//    }
//}
