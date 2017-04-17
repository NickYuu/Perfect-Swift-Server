//
//  DataBase.swift
//  MyPerfectServer
//
//  Created by TsungHan on 2017/4/17.
//
//

import PerfectLib
import MongoDB

class MongoConnect {
    
    var mongoURL: String {
        return "mongodb://localhost:27017"
    }
    var databaseName: String {
        return "Note"
    }
    var collectionName: String {
        return "users"
    }

    
    static func queryAll() -> String? {
        let bson = BSON()
        let client = try! MongoClient(uri: "mongodb://localhost:27017")
        let db = client.getDatabase(name: "Note")
        let collection = db.getCollection(name: "users")
        defer {
            collection?.close()
            db.close()
            client.close()
        }
        let fnd = collection?.find(query: BSON())
        
        return fnd?.jsonString
    }
    
    static func inserUser(acc:String, pwd:String) ->MongoResult {
        let client = try! MongoClient(uri: "mongodb://localhost:27017")
        let db = client.getDatabase(name: "Note")
        let collection = db.getCollection(name: "users")
        defer {
            collection?.close()
            db.close()
            client.close()
        }
        let bson = BSON()
        bson.append(key: "acc", string: acc)
        bson.append(key: "pwd", string: pwd)
        return collection!.insert(document: bson)
    }
    
    static func queryUser(acc:String) -> String? {
        let client = try! MongoClient(uri: "mongodb://localhost:27017")
        let db = client.getDatabase(name: "Note")
        let collection = db.getCollection(name: "users")
        defer {
            collection?.close()
            db.close()
            client.close()
        }
        let bson = BSON()
        bson.append(key: "acc", string: acc)
        
        return collection?.find(query: bson)?.jsonString
    }
    
    
    
}
