//
//  YZGitHubUserInfo.m
//  GitHubUsers
//
//  Created by Yuriy Zabroda on 5/20/14.
//  Copyright (c) 2014 Yuriy Zabroda. All rights reserved.
//

#import "YZGitHubUserInfo.h"

@implementation YZGitHubUserInfo


- (id)initWithLogin:(NSString *)login htmlUrl:(NSString *)htmlUrl
{
    self = [super init];
    if (self) {
        self.login = login;
        self.htmlUrl = htmlUrl;
    }
    
    return self;
}


@end
