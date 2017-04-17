import PackageDescription

let package = Package(
    name: "MyPerfectServer",
    targets: [],
    dependencies: [
        //HTTPServer
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2, minor: 0),
        
        .Package(url:"https://github.com/PerfectlySoft/PerfectLib.git", majorVersion: 2, minor: 0),
        
        // MongoDB
        .Package(url:"https://github.com/PerfectlySoft/Perfect-MongoDB.git", majorVersion: 2, minor: 0)
    ]
)
