//
//  YZGitHubDownloadManager.m
//  GitHubUsers
//
//  Created by Yuriy Zabroda on 5/20/14.
//  Copyright (c) 2014 Yuriy Zabroda. All rights reserved.
//

#import "YZGitHubDownloadManager.h"
#import "YZGitHubUserInfo.h"


@interface YZGitHubDownloadManager ()

// The operation queue to which the handler block will be dispatched
// when the download request completes or failed.
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end


@implementation YZGitHubDownloadManager


static NSString * const kGitHubUsersEndpointURL = @"https://api.github.com/users";


- (void)downloadGitHubUsersWithCompletion:(YZGitHubDownloadCompletionHandler)completionHandler
{
    self.operationQueue = [[NSOperationQueue alloc] init];

    NSURL *url = [NSURL URLWithString:kGitHubUsersEndpointURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:self.operationQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError != nil) {
                                   [self reportError:connectionError withCompletionHandler:completionHandler];
                               } else {
                                   NSError *error = nil;
                                   
                                   id gitHubResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:&error];
                                   if (error != nil) {
                                       [self reportError:error withCompletionHandler:completionHandler];

                                       return;
                                   }

                                   if (NO == [gitHubResponse isKindOfClass:[NSArray class]]) {
                                        NSError *error = [NSError errorWithDomain:@"Wrong class of URL response"
                                                                                code:0
                                                                            userInfo:nil];
                                        [self reportError:error withCompletionHandler:completionHandler];
                                   } else {
                                       NSArray *downloadedUsers = (NSArray *)gitHubResponse;
                                       NSMutableArray *collectedArray = [[NSMutableArray alloc] initWithCapacity:[downloadedUsers count]];

                                       for (NSDictionary *currentUserInfo in downloadedUsers) {
                                           YZGitHubUserInfo *userInfo = [[YZGitHubUserInfo alloc] initWithLogin:currentUserInfo[@"login"]
                                                                                                        htmlUrl:currentUserInfo[@"html_url"]];
                                           [collectedArray addObject:userInfo];
                                       }

                                       if (completionHandler) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completionHandler([collectedArray copy], nil);
                                           });
                                       }
                                   }
                               }
                           }];
}




#pragma mark -
#pragma mark Private Methods

- (void)reportError:(NSError *)error withCompletionHandler:(YZGitHubDownloadCompletionHandler)completionHandler
{
    if (completionHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(nil, error);
        });
    }
}


@end
