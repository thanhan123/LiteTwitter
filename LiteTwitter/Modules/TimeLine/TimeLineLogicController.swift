//
//  TimeLineLogicController.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 27/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import RxSwift

protocol TimeLineLogicController {
    var userId: String? { get set }
    func loadPosts(handler: @escaping ((Result<[Post]>) -> ()))
}

final class TimeLineLogicControllerProvider: TimeLineLogicController {
    
    var userId: String?
    
    private let disposeBag = DisposeBag()
    private let getCurrentUserActionObservable: Observable<User>
    private let getPostsActionObservable: Observable<[Post]>
    
    init(getCurrentUserAction: GetCurrentUserAction,
         getPostsAction: GetPostsAction) {
        self.getCurrentUserActionObservable = getCurrentUserAction.observable
        self.getPostsActionObservable = getPostsAction.observable
    }
    
    func loadPosts(handler: @escaping ((Result<[Post]>) -> ())) {
        let onNext: ([Post]) -> () = { (posts) in
            handler(.success(posts))
        }
        let onError: (Error) -> () = { (error) in
            handler(.failed(error))
        }
        
        if userId == nil {
            getCurrentUserActionObservable.do(onNext: { [weak self] (user) in
                self?.userId = user.id
            }).flatMap { [weak self] (user) -> Observable<[Post]> in
                return self?.getPostsActionObservable ?? Observable.empty()
                }.subscribe(
                    onNext: onNext,
                    onError: onError
                ).disposed(by: disposeBag)
        } else {
            getPostsActionObservable.subscribe(
                onNext: onNext,
                onError: onError
                ).disposed(by: disposeBag)
        }
    }
}

extension GetCurrentUserAction {
    
    var observable: Observable<User> {
        return Observable.create({ observer -> Disposable in
            self.getCurrentLocalUser.getCurrentUser(handler: { result in
                switch result {
                case let .success(user):
                    observer.onNext(user)
                    
                case let .failed(error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create()
        })
    }
}

extension GetPostsAction {
    
    var observable: Observable<[Post]> {
        return Observable.create({ observer -> Disposable in
            self.getPostsManager.getPosts(handler: { result in
                switch result {
                case let .success(posts):
                    observer.onNext(posts)
                    
                case let .failed(error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create()
        })
    }
}
