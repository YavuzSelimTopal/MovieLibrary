import Foundation

enum SearchRouter {
    case search(String)
    case user
    
    
    var urlString: String {
        switch self {
        case .search(let query):
            "\(Constants.URL.baseURLString)/search/\(query)"
        case .user:
            "\(Constants.URL.baseURLString)/users"
        }
    }
}
