//
//  TRMusicTool.m
//  LocalMusicPlayer
//
//  Created by tarena on 16/3/1.
//  Copyright © 2016年 EvilCompssion. All rights reserved.
//

#import "TRMusicTool.h"
#import "TRMusic.h"

@implementation TRMusicTool

+ (NSArray *)getMusicArray {
    static NSArray *_musicArray = nil;
    if (!_musicArray) {
        _musicArray = [TRMusicTool getMusicWithPlist:@"Musics.plist"];
    }
    
    return _musicArray;
}

+ (NSArray *) getMusicWithPlist:(NSString *)plistName {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSArray *musicArray = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in musicArray) {
        TRMusic *music = [TRMusic new];
        [music setValuesForKeysWithDictionary:dic];
        [mutableArray addObject:music];
    }
    return [mutableArray copy];
    
}
//记录当前正在播放歌曲对象
static TRMusic *_playingMusic = nil;
+ (void)setCurrentPlayingMusic:(TRMusic *)music {
    _playingMusic = music;
    
}

+ (TRMusic *)currentPlayingMusic {
    
    
    return _playingMusic;
}

@end
