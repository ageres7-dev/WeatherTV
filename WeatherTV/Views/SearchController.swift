//
//  SearchController.swift
//  WeatherTV
//
//  Created by Сергей on 18.04.2021.
//

import SwiftUI
import TVUIKit

struct SearchController: UIViewControllerRepresentable {

    @Binding var searchString: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SearchController>) ->
    UINavigationController {
        let controller = UISearchController(searchResultsController: context.coordinator)
        controller.searchResultsUpdater = context.coordinator
        return UINavigationController(rootViewController: UISearchContainerViewController(searchController: controller))
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<SearchController>) {
    }

    func makeCoordinator() -> SearchController.Coordinator {
        Coordinator(searchString: $searchString)
    }

    typealias UIViewControllerType = UINavigationController
    
    class Coordinator: UIViewController, UISearchResultsUpdating {
        @Binding var searchString: String
        
        init(searchString: Binding<String>) {
            
            self._searchString = searchString
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func updateSearchResults(for searchController: UISearchController) {
            // do here what's needed
            searchString = searchController.searchBar.text ?? ""
        }
    }
}

struct ContentView2: View {
    @State private var text: String = ""
    var body: some View {
        VStack {
            SearchController(searchString: .constant("d"))
            Spacer()
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

/*

struct SearchBar: UIViewRepresentable {
  typealias UIViewType = UISearchBar
  
  @Binding var searchTerm: String

  func makeUIView(context: Context) -> UISearchBar {
    let searchBar = UISearchBar(coder: <#T##NSCoder#>)
    searchBar.delegate = context.coordinator
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "Type a song, artist, or album name..."
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: Context) {
  }
  
  func makeCoordinator() -> SearchBarCoordinator {
    return SearchBarCoordinator(searchTerm: $searchTerm)
  }
  
  class SearchBarCoordinator: NSObject, UISearchBarDelegate {
    @Binding var searchTerm: String
    
    init(searchTerm: Binding<String>) {
      self._searchTerm = searchTerm
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchTerm = searchBar.text ?? ""
      UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
    }
  }
}
 
 */

