//
//  GitHubUsersTests.m
//  GitHubUsersTests
//
//  Created by Yuriy Zabroda on 5/20/14.
//  Copyright (c) 2014 Yuriy Zabroda. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YZGitHubDownloadManager.h"


@interface GitHubUsersTests : XCTestCase

@property (nonatomic, strong) YZGitHubDownloadManager *downloadManager;

@end

@implementation GitHubUsersTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testDownload
{
    __block BOOL notified = NO;

    self.downloadManager = [[YZGitHubDownloadManager alloc] init];
    [self.downloadManager downloadGitHubUsersWithCompletion:^(NSArray *userList, NSError *error) {
        XCTAssertFalse(error, @"An error occurred while downloading GitHub user list: %@", [error localizedDescription]);
        XCTAssertTrue([userList count] > 0, @"Downloaded GitHub user list is empty.");

        notified = YES;
    }];

    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.1];

    while (NO == notified) {
        BOOL runLoopStatus = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                                      beforeDate:date];
        XCTAssertTrue(runLoopStatus, @"The currentRunLoop could not be started.");

        date = [NSDate dateWithTimeIntervalSinceNow:0.1];
    }
}


@end
