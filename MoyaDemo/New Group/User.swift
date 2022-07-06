//
//  User.swift
//  MoyaDemo
//

import Foundation

struct User: Codable {
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id, title
    }
}
