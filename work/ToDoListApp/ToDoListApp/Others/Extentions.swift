//
//  Extentions.swift
//  ToDoListApp
//
//  Created by alinabi on 11/2/24.
//

import Foundation
extension Encodable {
    func asDictinary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:] 
           
        }
        catch {
            return [:]
        }
        
    }
}

