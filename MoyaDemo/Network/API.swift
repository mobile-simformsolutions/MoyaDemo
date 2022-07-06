//
//  API.swift
//  MoyaDemo
//

import Moya

enum API {
    case users
    case userDetail(userId: Int)
}

extension API: TargetType {
    
    // This is the base URL we'll be using, typically our server.
    var baseURL: URL {
        guard let url = URL(string: Constants.API.baseUrl) else { fatalError() }
        return url
    }
    
    // This is the path of each operation that will be appended to our base URL.
    var path: String {
        switch self {
        case .users:
            return Constants.API.users
        case .userDetail(let userId):
            return Constants.API.users + String(userId)
        }
    }
    
    // Here we specify which method our calls should use.
    var method: Method {
        return .get
    }
    
    // Here we specify body parameters, objects, files etc.
    // or just do a plain request without a body.
    // In this example we will not pass anything in the body of the request.
    var task: Task {
        switch self {
        case .users, .userDetail:
            return .requestPlain
        }
    }
    
    // These are the headers that our service requires.
    // Usually you would pass auth tokens here.
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    // This is sample return data that you can use to mock and test your services,
    // but we won't be covering this.
    var sampleData: Data {
        return Data()
    }
}
