//
//  ListViewControllerController.h
//  Feed
//
//  Created by Yongjia Liu on 14-5-21.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSSChannel;
@class WebViewController;
@interface ListViewControllerController : UITableViewController<NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    RSSChannel *channel;
    
    WebViewController *webViewController;
}
@property (nonatomic,retain)WebViewController *webViewController;
-(void)fetchEntries;
@end
