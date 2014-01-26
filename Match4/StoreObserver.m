//
//  StoreObserver.m
//  Match4
//
//  Created by apple on 14-1-14.
//  Copyright (c) 2014年 zhenwei. All rights reserved.
//

#import "StoreObserver.h"
#import <GameKit/GKScore.h>
#import "GameController.h"
#import "MoneyManager.h"
//#import "SVProgressHUD.h"

@implementation StoreObserver
@synthesize delegate, productRes;

-(id) init
{
    if (self = [super init]) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        //[self requestProductData];
    }
    return self;
}

-(void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler
{
    _completionHandler = [completionHandler copy];
    productsRequest = [[SKProductsRequest alloc]
                       initWithProductIdentifiers:[NSSet setWithObjects:
                                                   IAP_100_COINS,
                                                   IAP_500_COINS,
                                                   IAP_1000_COINS,
                                                   IAP_5000_COINS,
                                                   IAP_10000_COINS,
                                                   nil]];
    productsRequest.delegate = self;
    [productsRequest start];
}



- (void) purchase:(NSString *)purchase_id {
    if (![SKPaymentQueue canMakePayments]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"inApp purchase Disabled"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    int ID = 0;
    
    if ([purchase_id isEqual:IAP_100_COINS]) {
        ID = 0;
    } else if ([purchase_id isEqual:IAP_500_COINS]) {
        ID = 1;
    } else if ([purchase_id isEqual:IAP_1000_COINS]) {
        ID = 2;
    } else if ([purchase_id isEqual:IAP_5000_COINS]) {
        ID = 3;
    } else if ([purchase_id isEqual:IAP_10000_COINS]) {
        ID = 4;
    }
    
    SKProduct *productSK = [self.productRes objectAtIndex:ID];
    if (productSK == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Cannot connect to iTunes Connect"
                                                           delegate:self
                                                  cancelButtonTitle:@"Dismiss"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:productSK];
    //[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void) restorePurchases {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


#pragma mark SKPaymentTransactionObserver
-(void)failedTransaction: (SKPaymentTransaction  *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"transaction.error: %@", [transaction.error localizedDescription]);
        [delegate transactionDidError:transaction.error];
    }else{
        [delegate transactionDidError:nil];
    }
}

-(void)recordTransaction:(SKPaymentTransaction *)transaction
{
    
}

-(void)provideContent:(NSString *)identifier
{
    
}

-(void)completeTransaction:(SKPaymentTransaction *)transaction
{
    int price = 0;
    
    if ([transaction.payment.productIdentifier isEqualToString:IAP_100_COINS]) {
        [[GameController sharedController].moneyManager addCoins:100];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:@([GameController sharedController].moneyManager.coins) userInfo:nil];
    } else if ([transaction.payment.productIdentifier isEqualToString:IAP_500_COINS]) {
        [[GameController sharedController].moneyManager addCoins:500];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:@([GameController sharedController].moneyManager.coins) userInfo:nil];
    } else if ([transaction.payment.productIdentifier isEqualToString:IAP_1000_COINS]) {
        [[GameController sharedController].moneyManager addCoins:1000];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:@([GameController sharedController].moneyManager.coins) userInfo:nil];
    } else if ([transaction.payment.productIdentifier isEqualToString:IAP_5000_COINS]) {
        [[GameController sharedController].moneyManager addCoins:5000];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:@([GameController sharedController].moneyManager.coins) userInfo:nil];
    } else if ([transaction.payment.productIdentifier isEqualToString:IAP_10000_COINS]) {
        [[GameController sharedController].moneyManager addCoins:10000];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMoney" object:@([GameController sharedController].moneyManager.coins) userInfo:nil];
    }
    
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:price] forKey:@"price"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCounter" object:nil userInfo:dict];
    [delegate transactionDidFinish:transaction.payment.productIdentifier];
}

-(void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}



#pragma mark SKProductsRequestDelegate
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    productRes = [[NSMutableArray alloc] init];
    NSArray *skProducts = response.products;
    for (SKProduct * skProduct in skProducts) {
        NSLog(@"Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
        [productRes addObject:skProduct];
    }
    
    /*self.productRes = [NSMutableArray new];
    for (SKProduct *product in response.products) {
        [self.productRes addObject:product];
        NSLog(@"%@",product.productIdentifier);
    }
    [GameController sharedController].moneyManager.allIAP = response.products;
    [GameController sharedController].moneyManager.request = nil;
    //[[GameController sharedController].moneyManager.storeView showIAP];*/
    NSLog(@"success in loading list of products");
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"failed to load list of products");
    productsRequest = nil;
    _completionHandler(NO, nil);
    _completionHandler = nil;
}

@end
