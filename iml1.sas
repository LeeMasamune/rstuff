proc setinit; run;

proc iml;                      /* begin IML session */
   
start MySqrt(x);               /* begin module */
   y = 1;                      /* initialize y */
   do until(w<1e-3);           /* begin DO loop */
      z = y;                   /* set z=y */
      y = 0.5#(z+x/z);         /* estimate square root */
      w = abs(y-z);            /* compute change in estimate */
   end;                        /* end DO loop */
   return(y);                  /* return approximation */
finish;                        /* end module */
   
t = MySqrt({3,4,7,9});         /* call function MySqrt  */
s = sqrt({3,4,7,9});           /* compare with true values */
diff = t - s;                  /* compute differences */
print t s diff;                /* print matrices */

quit;

proc iml;

x = {1 . 3 4 5 6};             /* 1 x 6 row vector */
y = {1,2,3,4};                 /* 4 x 1 column vector */
z = 3#y;                       /* element-wise multiplication - 3 times the vector y */
w = {1 2, 3 4, 5 6};           /* 3 x 2 matrix */
print x, y z w;                /* note how y z w are combined in one output table */
  
a = { abc   defg};             /* no quotes; uppercase */
b = {'abc' 'DEFG'};            /* quotes; case preserved */
print a, b;

answer = {[2]  'Yes', [2]  'No'};
print answer;

answer = {'Yes' 'Yes', 'No' 'No'};
print answer;

a = {1 2 3, 6 5 4};            /* SAS/IML is dynamic */
a = {'Sales' 'Marketing' 'Administration'};

quit;

proc iml;

b = { 4 9 16, 25 36 49, 64 81 100 };
a = sqrt(b);                   /* elementwise square root */


*y = inv(a);                    /* matrix inversion */
y = inv(b);                    /* matrix inversion */

*print a b;
*print y;

c = b`;
print c b;


quit;

