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
    * R [Functions: `ls()` and `rm()`](#functions-ls-and-rm-p43)
    * R [Making a matrix](#making-a-matrix-p44)
    * R [Caret operator (`^`)](#caret-operator-^-p45)
    * R [Random numbers in normal distribution](#random-numbers-in-normal-distribution-p45)
---

## SAS and R

It is possible to submit R statements in `proc iml`. However, such a feature must be enabled (it does not work out of the box).

See documentation [here]().

[SAS Univeristy Edition]<br/>
The documentation explicitly states that:
>You cannot call R from the free SAS University Edition. The SAS University 
>Edition runs on a virtual machine that does not have R installed.

[Licensed environments]<br/>
The RLANG system option must be supported by the host. See documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_r_sect003.htm&docsetVersion=14.3&locale=en).

---

## 2.3.1 Basic Commands

---

### Declaring a vector (p43)

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

A vector in SAS/IML is a special matrix with dimensions of either 1×*n* or 
*m*×1. In contrast, R does not natively distinguish between row vectors and 
column vectors.[*1]

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

*From hereafter, R codes and output will be condensed similar to the code 
blocks in ISLR.*

*From hereafter, SAS logs will be omitted unless for the purpose of showing 
SAS log error messages.*

---

### Getting the vector length (p43)

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

Note how the a result of the `dimension()` function are two numbers, for the 
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

The result of the `dimension()` function is also a matrix. Documentation 
[here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect110.htm&docsetVersion=14.3&locale=en).

SAS/IML also has a lenghth function, but does not give the length of a vector. 
Documentation [here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect215.htm&docsetVersion=14.3&locale=en).

---

### Vector addition (p43)

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

SAS/IML will not add a 1×*n* matrix and an *m*×1 matrix.

---

### Functions: `ls()` and `rm()` (p43)

R:
```
> ls()
[1] "x" "y"
> rm(x,y)
> ls()
character (0)
```

No parallel SAS/IML codes for `ls` and `rm` have been found yet[*2].

> [*2] Needs verification

---

### Making a matrix (p44)

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
in the R `matrix()` method.

Documentation [here]().

There is no built-in `matrix()` function in SAS/IML. [*3]

> [*3] Needs verification

---

### Function `sqrt()` (p44)

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

The `sqrt()` function in SAS/IML seems the same as the `sqrt()` function in R.
Documentation [here](https://documentation.sas.com/?docsetId=imlug&docsetTarget=imlug_langref_sect461.htm&docsetVersion=14.3&locale=en).

---

### Caret operator (`^`) (p45)

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

### Random numbers in normal distribution (p45)

> TODO
