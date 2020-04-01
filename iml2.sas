ods html file='/folders/myshortcuts/test/~$iml2.html';

proc iml;
    x = { 1, 3, 2, 5 };
    print x;
quit;

proc iml;
    x = { 1, 6, 2 };
    d = dimension(x);
    title "dimension(x)";
    print d /;

    y = { 1, 4, 3 };
    d = dimension(y);
    title "dimension(y)";
    print d /;

	a = x + y;
    title "a = x + y";
    print a /;

    title;
quit;


ods html close;