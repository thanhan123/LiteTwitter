//  This file was automatically generated and should not be edited.

import Apollo

public final class GetUserQuery: GraphQLQuery {
    public let operationDefinition =
    "query GetUser($username: String!, $password: String!) {\n  allUsers(filter: {AND: [{username_in: [$username]}, {password_in: [$password]}]}) {\n    __typename\n    id\n    username\n  }\n}"
    
    public var username: String
    public var password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public var variables: GraphQLMap? {
        return ["username": username, "password": password]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes = ["Query"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("allUsers", arguments: ["filter": ["AND": [["username_in": [GraphQLVariable("username")]], ["password_in": [GraphQLVariable("password")]]]]], type: .nonNull(.list(.nonNull(.object(AllUser.selections))))),
            ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(allUsers: [AllUser]) {
            self.init(unsafeResultMap: ["__typename": "Query", "allUsers": allUsers.map { (value: AllUser) -> ResultMap in value.resultMap }])
        }
        
        public var allUsers: [AllUser] {
            get {
                return (resultMap["allUsers"] as! [ResultMap]).map { (value: ResultMap) -> AllUser in AllUser(unsafeResultMap: value) }
            }
            set {
                resultMap.updateValue(newValue.map { (value: AllUser) -> ResultMap in value.resultMap }, forKey: "allUsers")
            }
        }
        
        public struct AllUser: GraphQLSelectionSet {
            public static let possibleTypes = ["User"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("username", type: .nonNull(.scalar(String.self))),
                ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public init(id: GraphQLID, username: String) {
                self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username])
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var id: GraphQLID {
                get {
                    return resultMap["id"]! as! GraphQLID
                }
                set {
                    resultMap.updateValue(newValue, forKey: "id")
                }
            }
            
            public var username: String {
                get {
                    return resultMap["username"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "username")
                }
            }
        }
    }
}

public final class RegisterUserMutation: GraphQLMutation {
    public let operationDefinition =
    "mutation RegisterUser($username: String!, $password: String!) {\n  createUser(username: $username, name: $username, password: $password) {\n    __typename\n    id\n    username\n  }\n}"
    
    public var username: String
    public var password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public var variables: GraphQLMap? {
        return ["username": username, "password": password]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes = ["Mutation"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("createUser", arguments: ["username": GraphQLVariable("username"), "name": GraphQLVariable("username"), "password": GraphQLVariable("password")], type: .object(CreateUser.selections)),
            ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(createUser: CreateUser? = nil) {
            self.init(unsafeResultMap: ["__typename": "Mutation", "createUser": createUser.flatMap { (value: CreateUser) -> ResultMap in value.resultMap }])
        }
        
        public var createUser: CreateUser? {
            get {
                return (resultMap["createUser"] as? ResultMap).flatMap { CreateUser(unsafeResultMap: $0) }
            }
            set {
                resultMap.updateValue(newValue?.resultMap, forKey: "createUser")
            }
        }
        
        public struct CreateUser: GraphQLSelectionSet {
            public static let possibleTypes = ["User"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("username", type: .nonNull(.scalar(String.self))),
                ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public init(id: GraphQLID, username: String) {
                self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username])
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var id: GraphQLID {
                get {
                    return resultMap["id"]! as! GraphQLID
                }
                set {
                    resultMap.updateValue(newValue, forKey: "id")
                }
            }
            
            public var username: String {
                get {
                    return resultMap["username"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "username")
                }
            }
        }
    }
}

public final class AllPostsQuery: GraphQLQuery {
    public let operationDefinition =
    "query AllPosts {\n  allPosts(orderBy: updatedAt_DESC) {\n    __typename\n    ...PostDetails\n  }\n}"
    
    public var queryDocument: String { return operationDefinition.appending(PostDetails.fragmentDefinition) }
    
    public init() {
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes = ["Query"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("allPosts", arguments: ["orderBy": "updatedAt_DESC"], type: .nonNull(.list(.nonNull(.object(AllPost.selections))))),
            ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(allPosts: [AllPost]) {
            self.init(unsafeResultMap: ["__typename": "Query", "allPosts": allPosts.map { (value: AllPost) -> ResultMap in value.resultMap }])
        }
        
        public var allPosts: [AllPost] {
            get {
                return (resultMap["allPosts"] as! [ResultMap]).map { (value: ResultMap) -> AllPost in AllPost(unsafeResultMap: value) }
            }
            set {
                resultMap.updateValue(newValue.map { (value: AllPost) -> ResultMap in value.resultMap }, forKey: "allPosts")
            }
        }
        
        public struct AllPost: GraphQLSelectionSet {
            public static let possibleTypes = ["Post"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(PostDetails.self),
                ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var fragments: Fragments {
                get {
                    return Fragments(unsafeResultMap: resultMap)
                }
                set {
                    resultMap += newValue.resultMap
                }
            }
            
            public struct Fragments {
                public private(set) var resultMap: ResultMap
                
                public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                }
                
                public var postDetails: PostDetails {
                    get {
                        return PostDetails(unsafeResultMap: resultMap)
                    }
                    set {
                        resultMap += newValue.resultMap
                    }
                }
            }
        }
    }
}

public final class CreatePostMutation: GraphQLMutation {
    public let operationDefinition =
    "mutation CreatePost($title: String!, $content: String!, $authorId: ID!) {\n  createPost(title: $title, content: $content, authorId: $authorId) {\n    __typename\n    ...PostDetails\n  }\n}"
    
    public var queryDocument: String { return operationDefinition.appending(PostDetails.fragmentDefinition) }
    
    public var title: String
    public var content: String
    public var authorId: GraphQLID
    
    public init(title: String, content: String, authorId: GraphQLID) {
        self.title = title
        self.content = content
        self.authorId = authorId
    }
    
    public var variables: GraphQLMap? {
        return ["title": title, "content": content, "authorId": authorId]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes = ["Mutation"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("createPost", arguments: ["title": GraphQLVariable("title"), "content": GraphQLVariable("content"), "authorId": GraphQLVariable("authorId")], type: .object(CreatePost.selections)),
            ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(createPost: CreatePost? = nil) {
            self.init(unsafeResultMap: ["__typename": "Mutation", "createPost": createPost.flatMap { (value: CreatePost) -> ResultMap in value.resultMap }])
        }
        
        public var createPost: CreatePost? {
            get {
                return (resultMap["createPost"] as? ResultMap).flatMap { CreatePost(unsafeResultMap: $0) }
            }
            set {
                resultMap.updateValue(newValue?.resultMap, forKey: "createPost")
            }
        }
        
        public struct CreatePost: GraphQLSelectionSet {
            public static let possibleTypes = ["Post"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(PostDetails.self),
                ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var fragments: Fragments {
                get {
                    return Fragments(unsafeResultMap: resultMap)
                }
                set {
                    resultMap += newValue.resultMap
                }
            }
            
            public struct Fragments {
                public private(set) var resultMap: ResultMap
                
                public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                }
                
                public var postDetails: PostDetails {
                    get {
                        return PostDetails(unsafeResultMap: resultMap)
                    }
                    set {
                        resultMap += newValue.resultMap
                    }
                }
            }
        }
    }
}

public final class UpdatePostMutation: GraphQLMutation {
    public let operationDefinition =
    "mutation updatePost($title: String!, $content: String!, $id: ID!) {\n  updatePost(content: $content, title: $title, id: $id) {\n    __typename\n    ...PostDetails\n  }\n}"
    
    public var queryDocument: String { return operationDefinition.appending(PostDetails.fragmentDefinition) }
    
    public var title: String
    public var content: String
    public var id: GraphQLID
    
    public init(title: String, content: String, id: GraphQLID) {
        self.title = title
        self.content = content
        self.id = id
    }
    
    public var variables: GraphQLMap? {
        return ["title": title, "content": content, "id": id]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes = ["Mutation"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("updatePost", arguments: ["content": GraphQLVariable("content"), "title": GraphQLVariable("title"), "id": GraphQLVariable("id")], type: .object(UpdatePost.selections)),
            ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(updatePost: UpdatePost? = nil) {
            self.init(unsafeResultMap: ["__typename": "Mutation", "updatePost": updatePost.flatMap { (value: UpdatePost) -> ResultMap in value.resultMap }])
        }
        
        public var updatePost: UpdatePost? {
            get {
                return (resultMap["updatePost"] as? ResultMap).flatMap { UpdatePost(unsafeResultMap: $0) }
            }
            set {
                resultMap.updateValue(newValue?.resultMap, forKey: "updatePost")
            }
        }
        
        public struct UpdatePost: GraphQLSelectionSet {
            public static let possibleTypes = ["Post"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(PostDetails.self),
                ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var fragments: Fragments {
                get {
                    return Fragments(unsafeResultMap: resultMap)
                }
                set {
                    resultMap += newValue.resultMap
                }
            }
            
            public struct Fragments {
                public private(set) var resultMap: ResultMap
                
                public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                }
                
                public var postDetails: PostDetails {
                    get {
                        return PostDetails(unsafeResultMap: resultMap)
                    }
                    set {
                        resultMap += newValue.resultMap
                    }
                }
            }
        }
    }
}

public final class DeletePostMutation: GraphQLMutation {
    public let operationDefinition =
    "mutation DeletePost($id: ID!) {\n  deletePost(id: $id) {\n    __typename\n    id\n  }\n}"
    
    public var id: GraphQLID
    
    public init(id: GraphQLID) {
        self.id = id
    }
    
    public var variables: GraphQLMap? {
        return ["id": id]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes = ["Mutation"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("deletePost", arguments: ["id": GraphQLVariable("id")], type: .object(DeletePost.selections)),
            ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(deletePost: DeletePost? = nil) {
            self.init(unsafeResultMap: ["__typename": "Mutation", "deletePost": deletePost.flatMap { (value: DeletePost) -> ResultMap in value.resultMap }])
        }
        
        public var deletePost: DeletePost? {
            get {
                return (resultMap["deletePost"] as? ResultMap).flatMap { DeletePost(unsafeResultMap: $0) }
            }
            set {
                resultMap.updateValue(newValue?.resultMap, forKey: "deletePost")
            }
        }
        
        public struct DeletePost: GraphQLSelectionSet {
            public static let possibleTypes = ["Post"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public init(id: GraphQLID) {
                self.init(unsafeResultMap: ["__typename": "Post", "id": id])
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var id: GraphQLID {
                get {
                    return resultMap["id"]! as! GraphQLID
                }
                set {
                    resultMap.updateValue(newValue, forKey: "id")
                }
            }
        }
    }
}

public struct PostDetails: GraphQLFragment {
    public static let fragmentDefinition =
    "fragment PostDetails on Post {\n  __typename\n  id\n  author {\n    __typename\n    id\n  }\n  title\n  content\n  updatedAt\n}"
    
    public static let possibleTypes = ["Post"]
    
    public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("author", type: .nonNull(.object(Author.selections))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]
    
    public private(set) var resultMap: ResultMap
    
    public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
    }
    
    public init(id: GraphQLID, author: Author, title: String, content: String, updatedAt: String) {
        self.init(unsafeResultMap: ["__typename": "Post", "id": id, "author": author.resultMap, "title": title, "content": content, "updatedAt": updatedAt])
    }
    
    public var __typename: String {
        get {
            return resultMap["__typename"]! as! String
        }
        set {
            resultMap.updateValue(newValue, forKey: "__typename")
        }
    }
    
    public var id: GraphQLID {
        get {
            return resultMap["id"]! as! GraphQLID
        }
        set {
            resultMap.updateValue(newValue, forKey: "id")
        }
    }
    
    public var author: Author {
        get {
            return Author(unsafeResultMap: resultMap["author"]! as! ResultMap)
        }
        set {
            resultMap.updateValue(newValue.resultMap, forKey: "author")
        }
    }
    
    public var title: String {
        get {
            return resultMap["title"]! as! String
        }
        set {
            resultMap.updateValue(newValue, forKey: "title")
        }
    }
    
    public var content: String {
        get {
            return resultMap["content"]! as! String
        }
        set {
            resultMap.updateValue(newValue, forKey: "content")
        }
    }
    
    public var updatedAt: String {
        get {
            return resultMap["updatedAt"]! as! String
        }
        set {
            resultMap.updateValue(newValue, forKey: "updatedAt")
        }
    }
    
    public struct Author: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(id: GraphQLID) {
            self.init(unsafeResultMap: ["__typename": "User", "id": id])
        }
        
        public var __typename: String {
            get {
                return resultMap["__typename"]! as! String
            }
            set {
                resultMap.updateValue(newValue, forKey: "__typename")
            }
        }
        
        public var id: GraphQLID {
            get {
                return resultMap["id"]! as! GraphQLID
            }
            set {
                resultMap.updateValue(newValue, forKey: "id")
            }
        }
    }
}
