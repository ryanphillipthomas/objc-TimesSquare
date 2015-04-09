//
//  TSQCalendarMonthHeaderCell.h
//  TimesSquare
//
//  Created by Jim Puls on 11/14/12.
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.

#import "TSQCalendarCell.h"

/** The `TSQCalendarMonthHeaderCell` class displays the month name and day names at the top of a month's worth of weeks.
 
 By default, it lays out the day names in the bottom 20 points, the month name in the remainder of its height, and has a height of 65 points. You'll want to subclass it to change any of those things.
 */
@interface TSQCalendarMonthHeaderCell : TSQCalendarCell

/** @name Day Labels */

/** The day header labels.
 
 The count is equal to the `daysInWeek` property, likely seven. You can position them in the call to `layoutViewsForColumnAtIndex:inRect:`.
 */
@property (nonatomic, strong) NSArray *headerLabels;

/** Day header label date formatter pattern.
 
 "Su Mo Tu We Th Fr Sa" by default.
 */
@property (nonatomic, strong) NSString *headerLabelDateFormatterPattern;

/** Day header label background color.
 
 Defaults to the color passed into the -setBackgroundColor: method.
 */
@property (nonatomic, strong) UIColor *headerDayLabelBackgroundColor;

/** Day header label color.
 
 Defaults to the main text color.
 */
@property (nonatomic, strong) UIColor *headerDayLabelTextColor;

/** Day header label font.
 
 Defaults bold system font of size 12.0f.
 */
@property (nonatomic, strong) UIFont *headerDayLabelFont;

/** Month header label font.
 
 Defaults to system font of size 18.0f.
 */
@property (nonatomic, strong) UIFont *headerMonthLabelFont;

/** Month header label text color.
 
 Defaults to main text color.
 */
@property (nonatomic, strong) UIColor *headerMonthTextColor;

/** Day header label rect offset dx.

 Defaults to 0.0f.
 */
@property (nonatomic, assign) CGFloat headerLabelRectOffsetDX;

/** Day header label rect offset dy.
 
 Defaults to 5.0f.
 */
@property (nonatomic, assign) CGFloat headerLabelRectOffsetDY;

/** Month header cell height.
 
 Defaults to 20.0f.
 */
@property (nonatomic, assign) CGFloat headerCellMonthsHeight;

/** Control whether or not to show month (and year) header
 
 Defaults to NO.
 */
@property (nonatomic, assign) BOOL disableMonthHeaders;

/** If enabled, header day labels will have a top separator.
 
 Default is NO.
 */
@property (nonatomic, assign) BOOL showHeaderDayLabelTopSeparator;

/** If enabled, header day labels will have a bottom separator.
 
 Default is NO.
 */
@property (nonatomic, assign) BOOL showHeaderDayLabelBottomSeparator;

/** Header day label separator background.
 */
@property (nonatomic, strong) UIColor *headerDayLabelSeparatorBackgroundColor;

/** Month header background color.
 
 Default is clear color.
 */
@property (nonatomic, strong) UIColor *monthHeaderBackgroundColor;

/** Creates the header labels.
 
 If you want the text in your header labels to be something other than the short day format ("Mon Tue Wed" etc.), override this method, call `super`, and loop through `self.headerLabels`, changing their text.
 */
- (void)createHeaderLabels;

@end
