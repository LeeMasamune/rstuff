ods html file='/folders/myshortcuts/test/~$iml2.html' gpath='/folders/myshortcuts/test/';

/*

proc setinit; run;

proc iml;
    x = { 1, 3, 2, 5 };
    print x;
quit;

proc iml;
    colv = { 1, 2, 3, 4 };
    print colv;

    rowv = { 1  2  3  4 };
    print rowv;
quit;

proc iml;
    x = { 1, 6, 2 };
    y = { 1  4  3 };
    a = x + y;
    print a;
quit;

proc iml;
    x = { 1 3, 2 4 };
    print x;
quit;

proc iml;
    x = { 1 3, 2 4};
    a = sqrt(x);
    print a;
quit;

proc iml;
    x = { 1 3, 2 4};
    a = x ## 2;
    print a;
quit;

proc iml;
    x = randfun(50, "Normal");
    y = x + randfun(50, "Normal", 50, 0.1);
    m = x || y;
    c = corr(m);
    print c;
quit;

proc iml;
    call randseed(1303);
    run1 = randfun(5, "Normal"); * generates random numbers 1-5 ;
    run2 = randfun(5, "Normal"); * generates random numbers 6-10 ;
    
    call randseed(1303, 1); * resets the RNG ;
    run3 = randfun(10, "Normal"); * generates random numbers 1-10 ;
    
    print run1 run2 run3;
quit;

proc iml;
    call randseed(3);
    y = randfun(100, "Normal");

    a = mean(y);
    print "sample mean" a;

    a = var(y);
    print "sample variance" a;

    a = std(y);
    print "sample standard deviation" a;

quit;


proc iml;
    x = randfun(100, "Normal");
    y = randfun(100, "Normal");
    
    title "Plot of X vs Y";
    run scatter(x, y) label={"this is the x-axis" "is is the y-axis"};
    title;    * clears the title text ;
quit;

ods pdf file='/folders/myshortcuts/test/Figure-sas.pdf';

proc iml;
    x = randfun(100, "Normal");
    y = randfun(100, "Normal");
    
    run scatter(x, y) option="markerattrs=(color=green)";
quit;

ods pdf close;

proc iml;

    x = {};                                            * an empty matrix;
    
    * create 50 numbers of [-π, π] ;
    count = 50;
    pi = constant("pi");
    inc = (pi - (-pi)) / (count - 1);    
    do i = -pi to pi by inc;
        x = x // i;                                    * row concatenation ;
    end;
    
    * x now has 50 numbers from -π to π, inclusive ;

    y = x;

    *f = j(count, count, 0);              
    f = {};                                            * empty instead of a 50x50 matrix ;
    
    * the cross product for vectors x and y will be applied to f ;    
    * apply custom function cos(y)/(1+x^2) ;
    do i = 1 to count;
        do j = 1 to count;
            * f[i,j] = cos(y[j]) / (1 + x[i] ## 2);    * not a matrix anymore;
            f = f // (x[i] || y[j] || cos(y[j]) / (1 + x[i] ## 2));
        end;
    end;
    
    * f is now a 2500x3 matrix ;
    
    * create a dataset for use in proc gcontour ;
    create Example from f[colname={"X" "Y" "F"}]; 
        append from f;
    close Example;
    
    submit;
        proc plot data=Example;
            plot y*x=f / contour=10;
        run;
    endsubmit;

quit;

*/


ods html close;




































