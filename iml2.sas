ods html file='/folders/myshortcuts/test/~$iml2.html' gpath='/folders/myshortcuts/test/';

/**/

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
    
    call randseed(1303, 1); *Resets the RNG ;
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
        x = x // i;                                    *Row concatenation ;
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

proc iml;

    a = t(shape(1:16, 4, 4));
    print a;
    
    b = a[2, 3];
    print b;
    
    b = a[{1 3}, {2 4}];
    print b;
    
    b = a[1:3, 2:4];
    print b;
    
    b = a[1:2, ];
    print b;
    
    b = a[, 1:2];
    print b;
    
    b = a[1, ];
    print b;
    
    b = a[{-1 -3}];
    print b;
    
    d = dimension(a);
    print d;

quit;

proc iml;

    infile '/folders/myshortcuts/test/Auto.csv' dsd missover;
    
    Auto = {};
    
    *Read first line as column names ;
    input _V1 $ _V2 $ _V3 $ _V4 $ _V5 $ _V6 $ _V7 $ _V8 $ _V9 $;
    
    names = _V1 || _V2 || _V3 || _V4 || _V5 || _V6 || _V7 || _V8 || _V9;
    
    mattrib Auto colname=names;
    
    do data;
        input _V1 $ _V2 $ _V3 $ _V4 $ _V5 $ _V6 $ _V7 $ _V8 $ _V9 $;
        
        if _V1 = '?' then _V1 = '';
        if _V2 = '?' then _V2 = '';
        if _V3 = '?' then _V3 = '';
        if _V4 = '?' then _V4 = '';
        if _V5 = '?' then _V5 = '';
        if _V6 = '?' then _V6 = '';
        if _V7 = '?' then _V7 = '';
        if _V8 = '?' then _V8 = '';
        if _V9 = '?' then _V9 = '';
        
        Auto = Auto // (_V1 || _V2 || _V3 || _V4 || _V5 || _V6 || _V7 || _V8 || _V9) ;
        
    end;
    
    print Auto;
 
quit;

*   Import CSV data to dataset                                                  ;
*   '?' under columns inferred as numeric will be treated as null               ;
*       and an error message will be logged                                     ;
proc import dbms=csv file='/folders/myshortcuts/test/Auto.csv' out=AUTO replace;
run;

*Remove observations with null data ;
data Auto;
    set Auto;    * This is a rewrite ;
    
    _hasNull = 0;
    
    array nums{*} _numeric_;
    array chars{*} _character_;
    
    do i = 1 to dim(nums);
        if nums{i} = . then do;
            _hasNull = 1;
            leave;
        end;
    end;
    
    do i = 1 to dim(chars);
        if chars{i} = '' then do;
            _hasNull = 1;
            leave;
        end;
    end;
    
    if _hasNull then do;
        putlog "NOTE: NULL detected " _all_;
        delete;
    end;
    
    drop i _hasNull;
run;

proc iml;

    * Load dataset data to matrices ;
    use Auto;
    read all var {cylinders mpg};
    close Auto;
    
    *call box(mpg) category=cylinders;
    call histogram(mpg);
 
quit;

proc iml;

    use Auto; * Auto is an existing dataset and NOT a matrix ;
    summary var _all_; * _all_ does not get char vars;
    *summary var _char_; * Does not work for char vars ;
    close Auto;

quit;

*R> college = read.csv("College.csv") ;
proc import dbms=csv 
            file='/folders/myshortcuts/test/College.csv' 
            out=collegeds
            replace;
run;

* Since the first column in College.csv is unnamed, the default name put by SAS is VAR1 ;

* Load the dataset ;
proc iml;

    *R> rownames(college)=college[,1] ;
    *R> college=college[,-1] ;
    use collegeds;
    read all var { VAR1 } into names; * This picks the first column ;
    *read all var _all_ into college; * Does not not load char vars when num vars are present ;
    read all var _num_ into college[colname=varnames]; * This loads all numeric variables in collegds into the college matrix ;
    read all var { Private } ; * This loads the Private variable into its own vector, default name is also Private ;    
    
    mattrib college rowname=names;
    mattrib Private rowname=names;
    
    *R> fix(college) ;
    * SAS Studio can display the table when double clicked but edit not allowed ;
    * SAS Windowing Environment supports cell edits ;
    *print college Private; * The Private vector will be printed separately;
    
    *R> summary(college) ;
    * Almost there: SUMMARY statement ;
    *summary class {Private} 
            var _all_ 
            opt { print save }
    ;
    
    close collegeds;
    
    *R> summary(college) ;
    * Close enough: using procs freq and mean to mimic the output of R summary() ;
    submit;
        proc freq data=collegeds;
            *table _char_ / nocum nocol norow nopercent maxlevels=6; * This also shows the first column ;
            table Private / nocum nocol norow nopercent;
        run;
        
        proc means data=collegeds min q1 median mean q3 max;
            var _numeric_;
        run;
    endsubmit;
    
    *R> pairs(college[,1:10]) ;
    * Using proc sgscatter, but get subset first ;
    college10 = college[,1:10]; * These columns are the first 10 numeric columns in College.csv ;
    college10names = varnames[1:10] // { "Private" }; * Extra name for Private vector ;    
    create college10ds from college10 Private [colname=college10names];
    append from college10 Private;
    close college10ds;
    submit;
        proc sgscatter data=college10ds;
            *matrix _all_; * Does not support char vars ;
            matrix _numeric_ / group=Private;
            *matrix Apps Accept / group=Private;
        run;
    endsubmit;
    
    *R> plot(college$Private, college$Outstate) ;    
    call box(college[,"Outstate"]) category=Private label={"Outstate"};
    *call box(college[,"outstate"]) 
            category=Private 
            label={"Outstate"}
            datalabel=names;    * With "identify" ;
    
    *R> Elite=rep("No",nrow(college)) ; * TODO rep() ;
    d = dimension(college);
    Elite = j(d[1], 1, "No "); * "No " Must have extra space for allocation for "Yes" ;
    
    *R> Elite[college$Top10perc>50]="Yes" ; * Set "Yes" to Elite where Top10perc>50 ;
    Elite[loc(college[,"Top10perc"] > 50)] = "Yes"; * TODO loc() ;
    *print Elite;
quit;
    
    *R> Elite <- as.factor(Elite) ;
    * SAS/IML has no factors ;
    
    *R> college <- data.frame(college, Elite) ; * TODO data.frame() ;
    *college = college || Elite; * Does not work, cannot mix types;
    
    *R> summary(college) ;
    * Showing summary of just Elite instead ;
    create eliteds from Elite[colname="Elite"]; * Write data to dataset first ; * TODO create, append ;
    append from Elite;
    close eliteds;
    submit;
        proc freq data=eliteds;
            table Elite / nocum nocol norow nopercent;
        run;
    endsubmit;

    *R> plot(college$Elite, college$Outstate) ;
    call box(college[,"Outstate"]) category=Elite label={"Outstate"};
    
    *R> par(mfrow = c(2, 2)) ; * TODO par() ;
    * May have similar effects to SAS ODS statements ;
    
    *R> hist(college$Apps) ;
    *R> hist(college$Accept) ;
    *R> hist(college$Enroll) ;
    *R> hist(college$Outstate) ;
    call histogram(college[,"Apps"]);
    call histogram(college[,"Accept"]);
    call histogram(college[,"Enroll"]);
    call histogram(college[,"Outstate"]);

quit;

*ISLR> This exercise involves the Auto data set studied in the lab. ;
*R> Auto <- read.csv("Auto.csv", header = TRUE, na.strings = "?") ;
proc import dbms=csv file='/folders/myshortcuts/test/Auto.csv' out=autods replace;
run;

*ISLR> Make sure that the missing values have been removed from the data. ;
*R> Auto <- na.omit(Auto) ;
data autods;
    set autods;    * This is a rewrite ;
    
    _hasNull = 0;
    
    array nums{*} _numeric_;
    array chars{*} _character_;
    
    do i = 1 to dim(nums);
        if nums{i} = . then do;
            _hasNull = 1;
            leave;
        end;
    end;
    
    do i = 1 to dim(chars);
        if chars{i} = '' then do;
            _hasNull = 1;
            leave;
        end;
    end;
    
    if _hasNull then do;
        putlog "NOTE: NULL detected " _all_;
        delete;
    end;
    
    drop i _hasNull;
run;


*ISLR> Which of the predictors are quantitative, and which are qualitative? ;
* See var list ;
proc means data=autods range mean std;
    var mpg cylinders displacement horsepower weight acceleration;
run;

*ISLR> What is the range of each quantitative predictor? What is the mean and 
*   standard deviation of each quantitative predictor? ;
* See above proc means ;

*ISLR> Now remove the 10th through 85th observations. What is the range, mean, 
*   and standard deviation of each predictor in the subset of the data that remains? ;
data autods2;
    set autods;
    if (_n_ < 10) or (_n_ > 85) ; * Subsetting if ;
run;
proc means data=autods2 range mean std;
    var mpg cylinders displacement horsepower weight acceleration;
run;

*ISLR> Create some plots highlighting the relationships among the predictors. ;
*R> pairs(Auto) ;
proc sgscatter data=autods;
    matrix _numeric_;
run;

ods html close;



































