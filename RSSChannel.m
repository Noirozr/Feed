//
//  RSSChannel.m
//  Feed
//
//  Created by Yongjia Liu on 14-5-22.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"
@implementation RSSChannel
@synthesize items,title,shortDescription,parentParserDelegate;
-(id)init
{
    self=[super init];
    if (self) {
        items=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t%@ found a %@ element",self,elementName);
    if ([elementName isEqual:@"title"]) {
        currentString=[[NSMutableString alloc]init];
        [self setTitle:currentString];
    }else if([elementName isEqual:@"description"]){
        currentString=[[NSMutableString alloc]init];
        [self setShortDescription:currentString];
    }else if([elementName isEqual:@"item"]){
        RSSItem *entry=[[RSSItem alloc]init];
        [entry setParentParserDelegate:self];
        [parser setDelegate:entry];
        [items addObject:entry];
        entry=nil;
    }
}
-(void)parser:(NSXMLParser*)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString=nil;
    if ([elementName isEqual:@"channel"]) {
        [parser setDelegate:parentParserDelegate];
    }
}
@end
