//
//  KLHomePresent.m
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLHomePresent.h"

@implementation KLHomePresent

- (instancetype)init{
    self =[super init];
    if (self) {
        [self addObserver:self forKeyPath:@"contentKey" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


- (void)loadData {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray * array =@[@"",@"",@"",@"",@"",@"",@"",@""];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.successBlock){
                self.successBlock(array);
            }
            
        });
        
    });
}


- (void)didClickBtn:(UIButton *)button indexPath:(NSIndexPath *)indexPath {
    
    
    
}





- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    KLLog(@"=====%@",change[NSKeyValueChangeNewKey]);
    NSArray * array =@[@"",@"",@"",@"",@"",@"",@"",@""];

    NSMutableArray * mArray =[NSMutableArray arrayWithArray:array];
    
    @synchronized (self) {
        [mArray removeObject:change[NSKeyValueChangeNewKey]];
    }
    
    if(self.successBlock){
        self.successBlock(array);
    }
}


- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"contentKey"];
}



@end
