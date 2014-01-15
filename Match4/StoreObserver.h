//
//  StoreObserver.h
//  Match4
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>



@protocol StoreObserverProtocol<NSObject>

-(void)transactionDidFinish:(NSString*)transactionIdentifier;
-(void)transactionDidError:(NSError*)error;

@end


@interface StoreObserver : NSObject<SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    id <StoreObserverProtocol> delegate;
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
    
    NSMutableArray *productRes;
}

@property (nonatomic, assign) id <StoreObserverProtocol> delegate;
@property (nonatomic, retain) NSMutableArray *productRes;

- (void) purchase:(NSString*)purchase_id;
- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
- (void) restoreTransaction:(SKPaymentTransaction*)transaction;
- (void) completeTransaction:(SKPaymentTransaction*)transaction;
- (void) transactionDidFinish:(NSString*)transactionIdentifier;
- (void) transactionDidError:(NSError*)error;
- (void) sendResponse:(SKProductsResponse *)response;

- (void) requestProductData;
@end


@interface SKProduct (LocalizedPrice)

@property (nonatomic, readonly) NSString *localizedPrice;

@end