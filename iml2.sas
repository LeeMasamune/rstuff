ods html file='/folders/myshortcuts/test/~$iml2.html';

proc iml;
    x = { 1, 3, 2, 5 };
    print x;
quit;

ods html close;
