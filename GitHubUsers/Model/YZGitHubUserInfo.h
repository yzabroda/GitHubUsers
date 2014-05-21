//
//  YZGitHubUserInfo.h
//  GitHubUsers
//
//  Created by Yuriy Zabroda on 5/20/14.
//  Copyright (c) 2014 Yuriy Zabroda. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 *
 * @class YZGitHubUserInfo
 *
 * @abstract A very simple "model" class to store basic GitHub user info
 * which is downloaded from GitHub REST endpoint for users: https://api.github.com/users
 *
 */
@interface YZGitHubUserInfo : NSObject

- (id)initWithLogin:(NSString *)login htmlUrl:(NSString *)htmlUrl;

@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *htmlUrl;

@end
