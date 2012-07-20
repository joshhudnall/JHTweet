//
//  ViewController.m
//  Twitter Count Demo
//
//  Created by Josh Hudnall on 7/19/12.
//  Copyright (c) 2012 Josh Hudnall. All rights reserved.
//  http://joshhudnall.com
//
//  Licensed under the Apache 2.0 License
//  http://www.apache.org/licenses/LICENSE-2.0.html
//

#import "ViewController.h"
#import "JHTweet.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *_testArray;
@property (nonatomic) int _passedCount;
@property (nonatomic) int _failedCount;

@end

@implementation ViewController
@synthesize _testArray;
@synthesize _passedCount;
@synthesize _failedCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self._testArray = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"1", @"rowNum",
                        @"text http://example.com/pipe|character?yes|pipe|character", @"text",
                        @"text <a href=\"http://example.com/pipe|character?yes|pipe|character\">http://example.com/pipe|character?yes|pipe|character</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"2", @"rowNum",
                        @"text http://example.com", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"3", @"rowNum",
                        @"text http://example.com more text", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a> more text", @"expected",
                        nil],
                       //                       [NSDictionary dictionaryWithObjectsAndKeys:
                       //                        @"4", @"rowNum",
                       //                        @"いまなにしてるhttp://example.comいまなにしてる", @"text",
                       //                        @"いまなにしてる<a href=\"http://example.com\">http://example.com</a>いまなにしてる", @"expected",
                       //                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"5", @"rowNum",
                        @"text (http://example.com)", @"text",
                        @"text (<a href=\"http://example.com\">http://example.com</a>)", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"6", @"rowNum",
                        @"text (http://example.com/test)", @"text",
                        @"text (<a href=\"http://example.com/test\">http://example.com/test</a>)", @"expected",
                        nil],
                       //                       [NSDictionary dictionaryWithObjectsAndKeys:
                       //                        @"7", @"rowNum",
                       //                        @"text http://msdn.com/S(deadbeef)/page.htm", @"text",
                       //                        @"text <a href=\"http://msdn.com/S(deadbeef)/page.htm\">http://msdn.com/S(deadbeef)/page.htm</a>", @"expected",
                       //                        nil],
                       //                       [NSDictionary dictionaryWithObjectsAndKeys:
                       //                        @"8", @"rowNum",
                       //                        @"text http://msdn.microsoft.com/ja-jp/library/system.net.httpwebrequest(v=VS.100).aspx", @"text",
                       //                        @"text <a href=\"http://msdn.microsoft.com/ja-jp/library/system.net.httpwebrequest(v=VS.100).aspx\">http://msdn.microsoft.com/ja-jp/library/system.net.httpwebrequest(v=VS.100).aspx</a>", @"expected",
                       //                        nil],
                       //                       [NSDictionary dictionaryWithObjectsAndKeys:
                       //                        @"9", @"rowNum",
                       //                        @"text http://foo.com/(""onclick=""alert(1)"")", @"text",
                       //                        @"text <a href=""http://foo.com/"">http://foo.com/</a>(""onclick=""alert(1)"")", @"expected",
                       //                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"10", @"rowNum",
                        @"Parenthetically bad http://example.com/i_has_a_) thing", @"text",
                        @"Parenthetically bad <a href=\"http://example.com/i_has_a_\">http://example.com/i_has_a_</a>) thing", @"expected",
                        nil],
                       //                       [NSDictionary dictionaryWithObjectsAndKeys:
                       //                        @"11", @"rowNum",
                       //                        @"I enjoy Macintosh Brand computers: http://✪df.ws/ejp", @"text",
                       //                        @"I enjoy Macintosh Brand computers: <a href=\"http://✪df.ws/ejp\">http://✪df.ws/ejp</a>", @"expected",
                       //                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"12", @"rowNum",
                        @"test http://www.example.co.jp", @"text",
                        @"test <a href=\"http://www.example.co.jp\">http://www.example.co.jp</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"13", @"rowNum",
                        @"badly formatted http://foo!bar.com", @"text",
                        @"badly formatted http://foo!bar.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"14", @"rowNum",
                        @"badly formatted http://foo_bar.com", @"text",
                        @"badly formatted http://foo_bar.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"15", @"rowNum",
                        @"text:http://example.com", @"text",
                        @"text:<a href=\"http://example.com\">http://example.com</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"16", @"rowNum",
                        @"text http://example.com?", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>?", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"17", @"rowNum",
                        @"text http://example.com!", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>!", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"18", @"rowNum",
                        @"text http://example.com,", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>,", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"19", @"rowNum",
                        @"In http://example.com/test, Douglas explains 42.", @"text",
                        @"In <a href=\"http://example.com/test\">http://example.com/test</a>, Douglas explains 42.", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"20", @"rowNum",
                        @"text http://example.com.", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>.", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"21", @"rowNum",
                        @"text http://example.com:", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>:", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"22", @"rowNum",
                        @"text http://example.com;", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>;", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"23", @"rowNum",
                        @"text http://example.com]", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>]", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"24", @"rowNum",
                        @"text http://example.com)", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>)", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"25", @"rowNum",
                        @"text http://example.com}", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>}", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"26", @"rowNum",
                        @"text http://example.com=", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>=", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"27", @"rowNum",
                        @"text http://example.com'", @"text",
                        @"text <a href=\"http://example.com\">http://example.com</a>'", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"28", @"rowNum",
                        @"text /http://example.com", @"text",
                        @"text /http://example.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"29", @"rowNum",
                        @"text !http://example.com", @"text",
                        @"text !http://example.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"30", @"rowNum",
                        @"text =http://example.com", @"text",
                        @"text =http://example.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"31", @"rowNum",
                        @"@http://example.com", @"text",
                        @"@http://example.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"32", @"rowNum",
                        @"foo@bar.com", @"text",
                        @"foo@bar.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"33", @"rowNum",
                        @"<link rel='true'>http://example.com</link>", @"text",
                        @"<link rel='true'><a href=\"http://example.com\">http://example.com</a></link>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"34", @"rowNum",
                        @"http://example.com https://sslexample.com http://sub.example.com", @"text",
                        @"<a href=\"http://example.com\">http://example.com</a> <a href=\"https://sslexample.com\">https://sslexample.com</a> <a href=\"http://sub.example.com\">http://sub.example.com</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"35", @"rowNum",
                        @"http://example.mobi/path", @"text",
                        @"<a href=\"http://example.mobi/path\">http://example.mobi/path</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"36", @"rowNum",
                        @"http://foo.com/?#foo", @"text",
                        @"<a href=\"http://foo.com/?#foo\">http://foo.com/?#foo</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"37", @"rowNum",
                        @"foo.it twitter.co.jp foo.commerce foo.nettastic foo.us foo.co.uk", @"text",
                        @"foo.it twitter.co.jp foo.commerce foo.nettastic foo.us foo.co.uk", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"38", @"rowNum",
                        @ "http://foo.com AND https://bar.com AND www.foobar.com", @"text",
                        @"<a href=\"http://foo.com\">http://foo.com</a> AND <a href=\"https://bar.com\">https://bar.com</a> AND www.foobar.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"39", @"rowNum",
                        @"See http://example.com example.com", @"text",
                        @"See <a href=\"http://example.com\">http://example.com</a> example.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"40", @"rowNum",
                        @"http://www.flickr.com/photos/29674651@N00/4382024406", @"text",
                        @"<a href=\"http://www.flickr.com/photos/29674651@N00/4382024406\">http://www.flickr.com/photos/29674651@N00/4382024406</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"41", @"rowNum",
                        @"http://www.flickr.com/photos/29674651@N00/foobar", @"text",
                        @"<a href=\"http://www.flickr.com/photos/29674651@N00/foobar\">http://www.flickr.com/photos/29674651@N00/foobar</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"42", @"rowNum",
                        @"I think it's proper to end sentences with a period http://tell.me.com. Even when they contain a URL.", @"text",
                        @"I think it's proper to end sentences with a period <a href=\"http://tell.me.com\">http://tell.me.com</a>. Even when they contain a URL.", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"43", @"rowNum",
                        @"I think it's proper to end sentences with a period http://tell.me/why. Even when they contain a URL.", @"text",
                        @"I think it's proper to end sentences with a period <a href=\"http://tell.me/why\">http://tell.me/why</a>. Even when they contain a URL.", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"44", @"rowNum",
                        @"I think it's proper to end sentences with a period http://tell.me/why?=because.i.want.it. Even when they contain a URL.", @"text",
                        @"I think it's proper to end sentences with a period <a href=\"http://tell.me/why?=because.i.want.it\">http://tell.me/why?=because.i.want.it</a>. Even when they contain a URL.", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"45", @"rowNum",
                        @"Czech out sweet deals at http://mrs.domain-dash.biz ok?", @"text",
                        @"Czech out sweet deals at <a href=\"http://mrs.domain-dash.biz\">http://mrs.domain-dash.biz</a> ok?", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"46", @"rowNum",
                        @"See also: http://xn--80abe5aohbnkjb.xn--p1ai/", @"text",
                        @"See also: <a href=\"http://xn--80abe5aohbnkjb.xn--p1ai/\">http://xn--80abe5aohbnkjb.xn--p1ai/</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"47", @"rowNum",
                        @"Is www...foo a valid URL?", @"text",
                        @"Is www...foo a valid URL?", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"48", @"rowNum",
                        @"Is www.-foo.com a valid URL?", @"text",
                        @"Is www.-foo.com a valid URL?", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"49", @"rowNum",
                        @"Is www.foo-bar.com a valid URL?", @"text",
                        @"Is www.foo-bar.com a valid URL?", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"50", @"rowNum",
                        @"Is http://www.foo-bar.com a valid URL?", @"text",
                        @"Is <a href=\"http://www.foo-bar.com\">http://www.foo-bar.com</a> a valid URL?", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"51", @"rowNum",
                        @"Check out http://search.twitter.com/search?q=avro&lang=en", @"text",
                        @"Check out <a href=\"http://search.twitter.com/search?q=avro&amp;lang=en\">http://search.twitter.com/search?q=avro&amp;lang=en</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"52", @"rowNum",
                        @"Check out http://example.com/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", @"text",
                        @"Check out <a href=\"http://example.com/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\">http://example.com/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"53", @"rowNum",
                        @"example: http://twitter.com/otm_m@\"onmousedown=\"alert('foo')\" style=background-color:yellow;color:yellow;\"/", @"text",
                        @"example: <a href=\"http://twitter.com/otm_m\">http://twitter.com/otm_m</a>@\"onmousedown=\"alert('foo')\" style=background-color:yellow;color:yellow;\"/", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"54", @"rowNum",
                        @"Go to http://example.com/a+ or http://example.com/a-", @"text",
                        @"Go to <a href=\"http://example.com/a+\">http://example.com/a+</a> or <a href=\"http://example.com/a-\">http://example.com/a-</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"55", @"rowNum",
                        @"Go to http://example.com/a+?this=that or http://example.com/a-?this=that", @"text",
                        @"Go to <a href=\"http://example.com/a+?this=that\">http://example.com/a+?this=that</a> or <a href=\"http://example.com/a-?this=that\">http://example.com/a-?this=that</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"56", @"rowNum",
                        @"Go to http://example.com/view/slug-url-?foo=bar", @"text",
                        @"Go to <a href=\"http://example.com/view/slug-url-?foo=bar\">http://example.com/view/slug-url-?foo=bar</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"57", @"rowNum",
                        @"@user Try http:// example.com/path", @"text",
                        @"@user Try http:// example.com/path", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"58", @"rowNum",
                        @"@user Try http:// example.com/path", @"text",
                        @"@user Try http:// example.com/path", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"59", @"rowNum",
                        @"See: http://example.com/café", @"text",
                        @"See: <a href=\"http://example.com/café\">http://example.com/café</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"60", @"rowNum",
                        @"See: www.twitter.com or twitter.com/twitter", @"text",
                        @"See: www.twitter.com or twitter.com/twitter", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"61", @"rowNum",
                        @"http://www.flickr.com/photos/29674651@N00/4382024406 if you know what's good for you.", @"text",
                        @"<a href=\"http://www.flickr.com/photos/29674651@N00/4382024406\">http://www.flickr.com/photos/29674651@N00/4382024406</a> if you know what's good for you.", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"62", @"rowNum",
                        @"Check out: http://example.com/test&@chasesechrist", @"text",
                        @"Check out: <a href=\"http://example.com/test\">http://example.com/test</a>&@<a class=\"tweet-url username\" href=\"http://twitter.com/chasesechrist\">chasesechrist</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"63", @"rowNum",
                        @"See: http://example.com/@user", @"text",
                        @"See: <a href=\"http://example.com/\">http://example.com/</a>@<a class=\"tweet-url username\" href=\"http://twitter.com/user\">user</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"64", @"rowNum",
                        @"See: http://example.com/@user/", @"text",
                        @"See: <a href=\"http://example.com/@user/\">http://example.com/@user/</a>", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"65", @"rowNum",
                        @"See: http://x.xx.com/@\"style=\"color:pink\"onmouseover=alert(1)//", @"text",
                        @"See: <a href=\"http://x.xx.com/\">http://x.xx.com/</a>@\"style=\"color:pink\"onmouseover=alert(1)//", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"66", @"rowNum",
                        @"#http://twitter.com @http://twitter.com", @"text",
                        @"#http://twitter.com @http://twitter.com", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"67", @"rowNum",
                        @"#twitter.com #twitter.co.jp", @"text",
                        @"<a href=\"http://twitter.com/search?q=%23twitter\" title=\"#twitter\" class=\"tweet-url hashtag\">#twitter</a>.com <a href=\"http://twitter.com/search?q=%23twitter\" title=\"#twitter\" class=\"tweet-url hashtag\">#twitter</a>.co.jp", @"expected",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"68", @"rowNum",
                        @"@twitter.com @twitter.co.jp", @"text",
                        @"@<a class=\"tweet-url username\" href=\"http://twitter.com/twitter\">twitter</a>.com @<a class=\"tweet-url username\" href=\"http://twitter.com/twitter\">twitter</a>.co.jp", @"expected",
                        nil],
                       nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_testArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"Passed: %d, Failed: %d, Total: %d", _passedCount, _failedCount, [_testArray count]];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    } else {
        NSDictionary *rowData = [_testArray objectAtIndex:indexPath.row - 1];
        
        NSString *originalTweet = [rowData objectForKey:@"expected"];
        NSString *autolinkedTweet = [JHTweet autolinkedTweet:[rowData objectForKey:@"text"]];
        
        int originalLength = [[rowData objectForKey:@"text"] length];
        int adjustedLength = [JHTweet lengthOfTweet:[rowData objectForKey:@"text"]];
        
        NSString *passFail = ([autolinkedTweet isEqualToString:originalTweet]) ? @"Passed" : @"Failed";
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@ (From %d to %d)", [rowData objectForKey:@"rowNum"], passFail, originalLength, adjustedLength];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        
        if ([passFail isEqualToString:@"Passed"]) {
            cell.textLabel.textColor = [UIColor greenColor];
        } else {
            cell.textLabel.textColor = [UIColor redColor];
        }
    }
    
    return cell;
}

- (void)set_testArray:(NSArray *)in_testArray {
    self->_testArray = in_testArray;
    self._passedCount = 0;
    self._failedCount = 0;
    
    for (NSDictionary *rowData in _testArray) {
        NSString *originalTweet = [rowData objectForKey:@"expected"];
        NSString *autolinkedTweet = [JHTweet autolinkedTweet:[rowData objectForKey:@"text"]];
        
        BOOL passFail = ([autolinkedTweet isEqualToString:originalTweet]);
        
        if (passFail) {
            self._passedCount++;
        } else {
            self._failedCount++;
        }
    }
}

@end







