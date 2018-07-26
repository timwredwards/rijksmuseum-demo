//
//  ViewController.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 17/07/2018.
//  Copyright © 2018 Tim Edwards. All rights reserved.
//

import Foundation
import CoreData

struct ArtObject {
    let remoteId: String
    let title: String
    let artist: String
    let imageUrl: URL
    let starred: Bool
}

struct ArtRequest {
    let page:Int
    let starredOnly:Bool
}

extension ArtObject: Decodable {
    enum CodingKeys: String, CodingKey {
        case objectNumber
        case title
        case principalOrFirstMaker
        case imageUrl
        case webImage
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.remoteId = try container.decode(String.self, forKey: .objectNumber)
        self.title = try container.decode(String.self, forKey: .title)
        self.artist = try container.decode(String.self, forKey: .principalOrFirstMaker)
        let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .webImage)
        self.imageUrl = try webImage.decode(URL.self, forKey: .url)
        self.starred = false
    }
}

private struct ServerResponse: Decodable {
    let artObjects: [ArtObject]

    enum CodingKeys: String, CodingKey {
        case artObjects
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artObjects = try container.decode([ArtObject].self, forKey: .artObjects)
    }
}

class ArtService {
    func getArtResults(withRequest request:ArtRequest,
                       completion:@escaping (Result<[ArtObject], Error>)->Void){
        guard let url = URL(string: "https://www.rijksmuseum.nl/api/en/collection?key=VV23OnI1&format=json&ps=100&imgonly=true&s=relevance") else {
            fatalError()
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                fatalError()
            }
            let jsonDecoder = JSONDecoder()
            do {
                let result = try jsonDecoder.decode(ServerResponse.self, from: data)
                completion(.success(result.artObjects))
            } catch {
                fatalError()
            }
        }
        task.resume()
    }
}

//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Rijksmuseum")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()

//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//        let result = Art(remoteId: "123",
//                               title: "A nice piece of art",
//                               artist: "Timothy Edwards",
//                               imageUrl: URL(string: "https://secure.gravatar.com/avatar/27e2d00ab3715b944d9ce99a421a012b?s=192&d=mm&r=g")!,
//                               starred: false)

//    func getArtDetails(_ art:Art) -> (Result<Art, Error>)->Void
//    func setArtStarred(_ art:Art, starred:Bool)

//    struct Error: LocalizedError {
//        public enum Reason {
//            case generic
//        }
//        public let reason: Reason
//        public var errorDescription: String?
//    }
