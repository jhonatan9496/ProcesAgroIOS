//
//  JHOOfertaInstitucionalViewController.h
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 9/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOOfertaInstitucionalViewController : UIViewController{
    
}
// guarda los valores por parametro
@property (nonatomic, strong) NSString *textTituloOferta;
@property (nonatomic, strong) NSString *textDeescripcionOferta;
@property (nonatomic, strong) NSString *idOferta;

@property (weak, nonatomic) IBOutlet UILabel *labelTituloOferta;
@property (weak, nonatomic) IBOutlet UILabel *labelDescripcionOferta;




@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
