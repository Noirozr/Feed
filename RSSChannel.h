//
//  RSSChannel.h
//  Feed
//
//  Created by Yongjia Liu on 14-5-22.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSChannel : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentString;
    NSString *title;
    NSString *shortDescription;
    NSMutableArray *items;
    
    id __unsafe_unretained parentParserDelegate;
}
@property (nonatomic,assign)id parentParserDelegate;

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *shortDescription;
@property (nonatomic,readonly) NSMutableArray *items;
@end
