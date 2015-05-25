//
//  RSSItem.m
//  Feed
//
//  Created by Yongjia Liu on 14-5-25.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem
@synthesize title,link,parentParserDelegate,pubdate,shortDescription;
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element",self,elementName);
    if ([elementName isEqual:@"title"]) {
        currentString=[[NSMutableString alloc]init];
        [self setTitle:currentString];
    }else if([elementName isEqual:@"link"]){
        currentString=[[NSMutableString alloc]init];
        [self setLink:currentString];
    }else if([elementName isEqual:@"description"]){
        currentString=[[NSMutableString alloc]init];
        [self setShortDescription:currentString];
    }else if([elementName isEqual:@"pubDate"]){
        currentString=[[NSMutableString alloc]init];
        [self setPubdate:currentString];
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString=nil;
    if ([elementName isEqual:@"item"]) {
        [parser setDelegate:parentParserDelegate];
    }
}
@end
