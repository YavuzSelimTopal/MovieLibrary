import Foundation

enum SearchRouter: Endpoint {
    case getPosts
    case createPost(title: String, body: String, userId: Int)

    var path: String {
        switch self {
        case .getPosts: return "/posts"
        case .createPost: return "/posts"
            
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPosts: return .get
        case .createPost: return .post
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getPosts: return nil
        case .createPost: return nil
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getPosts:
            return nil
        case let .createPost(title, body, userId):
            return ["title": title, "body": body, "userId": userId]
        }
    }
}
