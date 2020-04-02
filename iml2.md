# ISL**R** Lab → SAS/IML

This is a record of exploring whether features of R can be reproduced in 
SAS/IML and so shall provide demonstrations where it does and alternatives 
where it doesn't.

The *Lab* sections of ISLR 7th printing will be used as basis.

## Contents
* ISLR [2.3.1 Basic Commands](#2.3.1-Basic-Commands)
    * R [Declaring a vector](#declaring-a-vector-p43)
    * SAS/IML [Row vectors vs column vectors](#row-vectors-vs-column-vectors)
    * R [Getting the vector length](#getting-the-vector-length-p43)
    * R [Vector addition](#vector-addition-p43)
    * R [Functions: `ls(...)` and `rm(...)`](#functions-ls-and-rm-p43)
    * R [Making a matrix](#making-a-matrix-p44)
    * R [Caret operator (`^`)](#caret-operator-^-p45)
    * R [Random numbers in normal distribution](#random-numbers-in-normal-distribution-p45)
    * R [Functions `mean(...)`, `var(...)` and `sd(...)`](#functions-mean-var-and-sd-p45)

---

## SAS/IML and R

It is possible to submit R statements in `proc iml`. However, such a feature 
must be enabled since it does not work out of the box. See documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_r_sect001.htm&docsetVersion=14.3&locale=en).

**SAS Univeristy Edition**<br/>
The documentation explicitly states that:
>You cannot call R from the free SAS University Edition. The SAS University 
>Edition runs on a virtual machine that does not have R installed.

**Licensed environments**<br/>
The RLANG system option must be supported by the host. See documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_r_sect003.htm&docsetVersion=14.3&locale=en).

---

## 2.3.1 Basic Commands

---

### Declaring a vector (p.43)

R code:
```r
x <- c(1,3,2,5)
x
```

R output:
```
[1] 1 3 2 5
```

SAS code:
```sas
proc iml;
    x = { 1, 3, 2, 5 };
    print x;
quit;
```

SAS log:
```
 73         proc iml;
 NOTE: IML Ready
 74             x = { 1, 3, 2, 5 };
 75             print x;
 76         quit;
 NOTE: Exiting IML.
 NOTE: PROCEDURE IML used (Total process time):
       real time           0.02 seconds
       cpu time            0.03 seconds
```

SAS results (HTML):
<table class="table" cellspacing="0" cellpadding="5" rules="all" frame="box" bordercolor="#C1C1C1" summary="Procedure IML: x">
<colgroup>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" scope="col">x</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1</td>
</tr>
<tr>
<td class="r data">3</td>
</tr>
<tr>
<td class="r data">2</td>
</tr>
<tr>
<td class="r data">5</td>
</tr>
</tbody>
</table>

---

### Row vectors vs column vectors

A vector in SAS/IML is a special matrix with dimensions of either *n*x1 "column 
vector" or 1×*p* "row vector". Documentation
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_languagechap_sect001.htm&docsetVersion=14.3&locale=en).

In contrast, R does not natively distinguish 
between row vectors and column vectors.[*1]

> [*1] Needs verification: "R does not..."

SAS code (additional example):
```sas
proc iml;
    colv = { 1, 2, 3, 4 };
    print colv;

    rowv = { 1  2  3  4 };
    print rowv;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: colv" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" scope="col">colv</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1</td>
</tr>
<tr>
<td class="r data">2</td>
</tr>
<tr>
<td class="r data">3</td>
</tr>
<tr>
<td class="r data">4</td>
</tr>
</tbody>
</table>

<table class="table" rules="all" frame="box" summary="Procedure IML: rowv" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">rowv</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1</td>
<td class="r data">2</td>
<td class="r data">3</td>
<td class="r data">4</td>
</tr>
</tbody>
</table>

Note how an explicitly-written row vector does not have commas.

---

### Getting the vector length (p.43)

R:
```
> x = c(1,6,2)
> y = c(1,4,3)
> length(x)
[1] 3
> length(y)
[1] 3
```
SAS code:
```sas
proc iml;
    x = { 1, 6, 2 };
    d = dimension(x);
    print "vector length of x" d;

    y = { 1, 4, 3 };
    d = dimension(y);
    print "vector length of y" d;
quit;
```

Print message added for distinction.

SAS results (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: d" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c headerempty" scope="col">&nbsp;</th>
<th class="r b header" scope="col">d</th>
<th class="c headerempty" scope="col">&nbsp;</th>
</tr>
</thead>
<tbody>
<tr>
<td class="l data">vector length of x</td>
<td class="r data">3</td>
<td class="r data">1</td>
</tr>
</tbody>
</table>
<table class="table" rules="all" frame="box" summary="Procedure IML: d" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c headerempty" scope="col">&nbsp;</th>
<th class="r b header" scope="col">d</th>
<th class="c headerempty" scope="col">&nbsp;</th>
</tr>
</thead>
<tbody>
<tr>
<td class="l data">vector length of y</td>
<td class="r data">3</td>
<td class="r data">1</td>
</tr>
</tbody>
</table>

Note that the a result of the `dimension(m)` function are two numbers, for the 
number of rows and columns, respectively.

Aternatively if y is a row vector:

SAS code (additional example):
```sas
proc iml;
    y = { 1  4  3 };
    d = dimension(y);
    print "vector length of y" d;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: d" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c headerempty" scope="col">&nbsp;</th>
<th class="r b header" scope="col">d</th>
<th class="c headerempty" scope="col">&nbsp;</th>
</tr>
</thead>
<tbody>
<tr>
<td class="l data">vector length of y</td>
<td class="r data">1</td>
<td class="r data">3</td>
</tr>
</tbody>
</table>

The result of the `dimension(m)` function is also a matrix. Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect110.htm&docsetVersion=14.3&locale=en).

SAS/IML also has a length function, but does not give the length of a vector. 
Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect215.htm&docsetVersion=14.3&locale=en).

---

### Vector addition (p.43)

R:
```
> x+y
[1] 2 10 5
```

SAS code:
```sas
proc iml;
    x = { 1, 6, 2 };
    y = { 1, 4, 3 };
    a = x + y;
    print a;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: a" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" scope="col">a</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">2</td>
</tr>
<tr>
<td class="r data">10</td>
</tr>
<tr>
<td class="r data">5</td>
</tr>
</tbody>
</table>

Note that vector addition in SAS/IML is the same operation as matrix addition 
and requires that the two operands have exactly the same dimensions.

SAS code (additional example):
```sas
proc iml;
    x = { 1, 6, 2 };
    y = { 1  4  3 };
    a = x + y;
    print a;
quit;
```

SAS log:
```
 93         proc iml;
 NOTE: IML Ready
 94             x = { 1, 6, 2 };
 95             y = { 1  4  3 };
 96             a = x + y;
 ERROR: (execution) Matrices do not conform to the operation.
```

SAS/IML will not add an *n*×1 matrix and a 1×*p* matrix.

---

### Functions: `ls(...)` and `rm(...)` (p.43)

R:
```
> ls()
[1] "x" "y"
> rm(x,y)
> ls()
character (0)
```

No parallel SAS/IML codes for `ls(...)` and `rm(...)` have been found yet.[*2]

> [*2] Needs verification

---

### Making a matrix (p.44)

R:
```
> x=matrix(data=c(1,2,3,4), nrow=2, ncol=2)
> x
     [,1] [,2]
[1,]    1    3
[2,]    2    4
```

SAS code:
```sas
proc iml;
    x = { 1 3, 2 4 };
    print x;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: x" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">x</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1</td>
<td class="r data">3</td>
</tr>
<tr>
<td class="r data">2</td>
<td class="r data">4</td>
</tr>
</tbody>
</table>

In SAS/IML, the syntax for explicit declarationis the same for matrices, 
vectors and scalars. Note how spaces and commas in the SAS/IML declaration 
arrange the items in the resulting matrix.

R:
```
> matrix (c(1,2,3,4),2,2,byrow=TRUE)
[,1] [,2]
[1,] 1 2
[2,] 3 4
```

SAS code:
```sas
proc iml;
    x = { 1 2, 3 4 };
    print x;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: x" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">x</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1</td>
<td class="r data">2</td>
</tr>
<tr>
<td class="r data">3</td>
<td class="r data">4</td>
</tr>
</tbody>
</table>

The behavior of the SAS/IML declaration seems to mimic the `byrow=TRUE` option 
in the R `matrix()` method. Which elements go to which row and column are 
controlled by where commas are placed. Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_workmatrix_sect002.htm&docsetVersion=14.3&locale=en).

There is no built-in `matrix()` function in SAS/IML. [*3]

> [*3] Needs verification

---

### Function `sqrt()` (p.44)

R:
```
> sqrt(x)
     [,1] [,2]
[1,] 1.00 1.73
[2,] 1.41 2.00
```

SAS code: 
```sas
proc iml;
    x = { 1 3, 2 4};
    a = sqrt(x);
    print a;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: a" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">a</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1</td>
<td class="r data">1.7320508</td>
</tr>
<tr>
<td class="r data">1.4142136</td>
<td class="r data">2</td>
</tr>
</tbody>
</table>

The `sqrt(m)` function in SAS/IML seems the same as the `sqrt(...)` function in 
R. Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect461.htm&docsetVersion=14.3&locale=en).

---

### Caret operator (`^`) (p.45)

R:
```
> x ^ 2
     [,1] [,2]
[1,]    1    9
[2,]    4   16
```

SAS code:
```sas
proc iml;
    x = { 1 3, 2 4};
    a = x ## 2;
    print a;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: a" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">a</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1</td>
<td class="r data">9</td>
</tr>
<tr>
<td class="r data">4</td>
<td class="r data">16</td>
</tr>
</tbody>
</table>

The elementwise power operator (`##` in `m ## s`) raises each element in matrix 
`m` to the scalar `s`-th power.

The caret operator in SAS/IML is a prefix operator for logical NOT. 
Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect042.htm&docsetVersion=14.3&locale=en).

SAS/IML also has a matrix power operator (`**` in `m ** p`), which multiples a 
matrix `m` by itself `p` times. Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect046.htm&docsetVersion=14.3&locale=en).

### Random numbers in normal distribution (p.45)

R:
```
> x=rnorm(50)
> y=x+rnorm(50,mean=50,sd=.1)
> cor(x,y)
[1] 0.995
```

SAS code:
```sas
proc iml;
    x = randfun(50, "Normal");
    y = x + randfun(50, "Normal", 50, 0.1);
    m = x || y;
    c = corr(m);
    print c;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: c" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">c</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1</td>
<td class="r data">0.9952377</td>
</tr>
<tr>
<td class="r data">0.9952377</td>
<td class="r data">1</td>
</tr>
</tbody>
</table>

The SAS/IML function `randfun(...)` may accept other types of distribution 
other than "Normal". Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect336.htm&docsetVersion=14.3&locale=en).

There is also `randnormal(n, mean, cov)` that has a different third parameter. 
Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect375.htm&docsetVersion=14.3&locale=en).

The `corr(...)` function accepts a matrix and outputs a matrix. The 
function does not accept mutiple vectors as in R. Multiple vectors must be 
combined into a *m*×*p* matrix. Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect085.htm&docsetVersion=14.3&locale=en).

To put the column vectors x and y into once matrix they were concatenated using the horizontal concatenation operator `||`. Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect032.htm&docsetVersion=14.3&locale=en).

---

### Random seed (p.45)

R:
```
> set.seed(1303)
> rnorm(50)
[1] -1.1440 1.3421 2.1854 0.5364 0.0632 0.5022 -0.0004
...
```

Note that different builds of R (64-bit vs 32-bit, Windows vs Unix, etc.) may 
have differences in results. Consecutive calls to `rnorm(...)` will move the 
random number generator forward:

R (additional example):
```
> set.seed(1303)    # seed set to 1303
> rnorm(5)          # shows random numbers 1-5 for seed 1303
[1] -1.14397631  1.34212937  2.18539048  0.53639252  0.06319297
>
> set.seed(1303)    # seed set to 1303
> rnorm(5)          # shows random numbers 1-5 for seed 1303
[1] -1.14397631  1.34212937  2.18539048  0.53639252  0.06319297
>
> rnorm(5)          # shows random numbers 6-10 for seed 1303
[1]  0.5022344825 -0.0004167247  0.5658198405 -0.5725226890 -1.1102250073
>
> set.seed(1303)    # seed set to 1303
> rnorm(10)         # shows random numbers 1-10 for seed 1303
[1] -1.1439763145  1.3421293656  2.1853904757  0.5363925179  0.0631929665
[6]  0.5022344825 -0.0004167247  0.5658198405 -0.5725226890 -1.1102250073
```

> Computers are deterministic at the core and predictability is in 
> the design. True randomness comes outside from the system as an input 
> — a "true random" computer only *gets* this input in an automated manner 
> (e.g., atmospheric sensor data, quantum phenomena). 
> [Ask an engineer](https://engineering.mit.edu/engage/ask-an-engineer/can-a-computer-generate-a-truly-random-number/).
>
> The 
> [`RDRAND` instruction](https://en.wikipedia.org/wiki/RDRAND)
> which is available in modern, publicly-available CPUs  uses thermal noise 
> within the silicon to seed its random number generator. The random factor is 
> still an input, and any random number generated from this scheme does not 
> come from pure calculation. *The CPU itself does not make the random, it gets 
> the random from somewhere else.*

SAS code:

```sas
proc iml;
    call randseed(1303);
    x = randfun(5, "Normal");
    print x;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: x" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" scope="col">x</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">0.2875899</td>
</tr>
<tr>
<td class="r data" nowrap="">-0.685311</td>
</tr>
<tr>
<td class="r data" nowrap="">-2.033587</td>
</tr>
<tr>
<td class="r data" nowrap="">-1.019879</td>
</tr>
<tr>
<td class="r data" nowrap="">-0.269627</td>
</tr>
</tbody>
</table>

Note how SAS/IML has a different result from random numbers generated in R even 
for the same seed value.

The `randseed(...)` call will only reset SAS's random number generation only 
if a true value is passed as a second argument. Documentation
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect379.htm&docsetVersion=14.3&locale=en).

SAS code (additional example):
```sas
proc iml;
    call randseed(1303);
    run1 = randfun(5, "Normal");     * generates random numbers 1-5 ;
    run2 = randfun(5, "Normal");     * generates random numbers 6-10 ;
    
    call randseed(1303, 1);          * resets the RNG ;
    run3 = randfun(10, "Normal");    * generates random numbers 1-10 ;
    
    print run1 run2 run3;
quit;
```

SAS result (HTML):
<table class="table" rules="all" frame="box" summary="Procedure IML: run1_run2_run3" cellspacing="0" cellpadding="5" bordercolor="#C1C1C1">
<colgroup>
<col>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="r b header" scope="col">run1</th>
<th class="r b header" scope="col">run2</th>
<th class="r b header" scope="col">run3</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">0.2875899</td>
<td class="r data">0.269403</td>
<td class="r data">0.2875899</td>
</tr>
<tr>
<td class="r data" nowrap="">-0.685311</td>
<td class="r data">0.6187675</td>
<td class="r data" nowrap="">-0.685311</td>
</tr>
<tr>
<td class="r data" nowrap="">-2.033587</td>
<td class="r data" nowrap="">-0.217801</td>
<td class="r data" nowrap="">-2.033587</td>
</tr>
<tr>
<td class="r data" nowrap="">-1.019879</td>
<td class="r data" nowrap="">-0.540015</td>
<td class="r data" nowrap="">-1.019879</td>
</tr>
<tr>
<td class="r data" nowrap="">-0.269627</td>
<td class="r data">1.4973863</td>
<td class="r data" nowrap="">-0.269627</td>
</tr>
<tr>
<td class="r data">&nbsp;</td>
<td class="r data">&nbsp;</td>
<td class="r data">0.269403</td>
</tr>
<tr>
<td class="r data">&nbsp;</td>
<td class="r data">&nbsp;</td>
<td class="r data">0.6187675</td>
</tr>
<tr>
<td class="r data">&nbsp;</td>
<td class="r data">&nbsp;</td>
<td class="r data" nowrap="">-0.217801</td>
</tr>
<tr>
<td class="r data">&nbsp;</td>
<td class="r data">&nbsp;</td>
<td class="r data" nowrap="">-0.540015</td>
</tr>
<tr>
<td class="r data">&nbsp;</td>
<td class="r data">&nbsp;</td>
<td class="r data">1.4973863</td>
</tr>
</tbody>
</table>

---

### Functions `mean(...)`, `var(...)` and `sd(...)` (p.45)

> TODO
