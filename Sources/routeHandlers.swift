//
//  routeHandlers.swift
//  MyPerfectServer
//
//  Created by TsungHan on 2017/4/17.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import MongoDB

var mongoURL = "mongodb://localhost:27017"

public func signupRoutes() -> Routes {
    return addURLRoutes()
}

func addURLRoutes() -> Routes {
    var routes = Routes()
    routes.add(method: .get, uri: "/", handler: helloHandler)
    routes.add(method: .get, uri: "/mongo", handler: queryAll)
    routes.add(method: .post, uri: "/insUser", handler: insUser)
    routes.add(method: .post, uri: "/queryUser", handler: queryUser)
    return routes
}

func helloHandler(request: HTTPRequest, _ response: HTTPResponse) {
    response.appendBody(string: "<html><title>Hello</title><body>Hello World</body></html>")
    response.completed()
}

func queryAll(request: HTTPRequest, _ response: HTTPResponse) {
    let json = MongoConnect.queryAll()
    response.appendBody(string: json ?? "")
    response.completed()
}

func insUser(request: HTTPRequest, _ response: HTTPResponse) {
    let acc = request.param(name: "acc")
    let pwd = request.param(name: "pwd")
    let status = MongoConnect.inserUser(acc: acc!, pwd: pwd!)
    
    switch status {
    case .success:
        response.appendBody(string: "成功")
        response.completed()
    case .replyDoc(let json):
        response.appendBody(string: json.asString)
        response.completed()
    case .error(_, let code, let msg):
        response.appendBody(string: "\(code) : " + msg)
        response.completed()
    default:
        response.appendBody(string: "失敗")
        response.completed()
    }
}

func queryUser(request: HTTPRequest, _ response: HTTPResponse) {
    guard let acc = request.param(name: "acc") else {
        response.appendBody(string: "錯誤")
        response.completed()
        return
    }
    guard let json = MongoConnect.queryUser(acc:acc) else {
        response.appendBody(string: "錯誤")
        response.completed()
        return
    }
    if json == "[]" {
        response.appendBody(string: "NO")
        response.completed()
    }
    response.appendBody(string: json)
    response.completed()
}






