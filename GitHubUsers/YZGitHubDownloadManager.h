//
//  YZGitHubDownloadManager.h
//  GitHubUsers
//
//  Created by Yuriy Zabroda on 5/20/14.
//  Copyright (c) 2014 Yuriy Zabroda. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^YZGitHubDownloadCompletionHandler)(NSArray *userList, NSError *error);


/*!
 *
 * @class YZGitHubDownloadManager
 *
 * @abstract A class responsible for downloading various stuff from GitHub web services.
 *
 * @discussion Currently only https://api.github.com/users downloading is supported.
 *
 */
@interface YZGitHubDownloadManager : NSObject


/*!
 *
 * @method downloadGitHubUsersWithCompletion:
 *
 * @abstract Asynchronously downloads a list of GitHub users from their REST API endpoint.
 *
 * @param completionHandler A block object to be executed on completion of downloading or if an error occurs.
 * If download is successful, the userList argument will contain an array of YZGitHubUserInfo instances
 * filled with basic user info, and the error will be set to nil. If download failed, the error argument
 * will contain the error describing the network or parsing error that occurred.
 *
 */
- (void)downloadGitHubUsersWithCompletion:(YZGitHubDownloadCompletionHandler)completionHandler;

@end
