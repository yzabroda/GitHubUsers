//
//  YZMasterViewController.m
//  GitHubUsers
//
//  Created by Yuriy Zabroda on 5/20/14.
//  Copyright (c) 2014 Yuriy Zabroda. All rights reserved.
//

#import "YZMasterViewController.h"
#import "YZGitHubDownloadManager.h"
#import "YZGitHubUserInfo.h"


@interface YZMasterViewController ()

@property (nonatomic, strong) YZGitHubDownloadManager *downloadManager;
@property (nonatomic, strong) NSArray *gitHubUserList;

@end


@implementation YZMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    self.downloadManager = [[YZGitHubDownloadManager alloc] init];
    [self.downloadManager downloadGitHubUsersWithCompletion:^(NSArray *userList, NSError *error) {
        if (error == nil) {
            self.gitHubUserList = userList;
        } else {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Download error"
                                                                 message:[NSString stringWithFormat:@"An error occurred while downloading GitHub user list: %@", [error localizedDescription]]
                                                                delegate:self
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
            [errorAlert show];
        }

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.downloadManager = nil;
        [self.tableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;

    if (self.downloadManager) {
        numberOfRows = 1;
    } else {
        numberOfRows = [_gitHubUserList count];
    }

    return numberOfRows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    if (self.downloadManager) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Loading" forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        YZGitHubUserInfo *userInfo = _gitHubUserList[indexPath.row];

        cell.textLabel.text = userInfo.login;
        cell.detailTextLabel.text = userInfo.htmlUrl;
    }

    return cell;
}


@end
