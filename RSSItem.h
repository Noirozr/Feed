//
//  RSSItem.h
//  Feed
//
//  Created by Yongjia Liu on 14-5-25.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSItem : NSObject<NSXMLParserDelegate>
{
    NSString *title;
    NSString *link;
    NSString *shortDescription;
    NSString *pubdate;
    NSMutableString *currentString;
    
    id __unsafe_unretained parentParserDelegate;
}
@property (nonatomic,assign) id parentParserDelegate;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *link;
@property (nonatomic,retain) NSString *pubdate;
@property (nonatomic,retain) NSString *shortDescription;
@end
