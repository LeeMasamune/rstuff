# ISL**R** Lab → SAS/IML

This is a record of exploring whether features of R can be reproduced in 
SAS/IML and so shall provide demonstrations where it does and alternatives 
where it doesn't.

The *Lab* sections of ISLR 7th printing will be used as basis.

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

### Page 43

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

*From hereafter, R codes and output will be condensed similar to the code 
blocks in ISLR.*


R:
```
> x = c(1,6,2)
> x
[1] 1 6 2
> y = c(1,4,3)
> length(x)
[1] 3
> length(y)
[1] 3
> x+y
[1] 2 10 5
```
SAS code:
```sas
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
```

`title` statements and page separators (`/` in the `print` statement) added for 
clarity.

*From hereafter, SAS logs will be omitted unless for the purpose of showing 
SAS log error messages.*

SAS results (HTML):
<div class="branch">
<table class="systitleandfootercontainer" width="100%" cellspacing="1" cellpadding="1" rules="none" frame="void" border="0" summary="Page Layout">
<tbody><tr>
<td class="c systemtitle">dimension(x)</td>
</tr>
</tbody></table><br>
<div>
<div align="center">
<table class="table" cellspacing="0" cellpadding="5" rules="all" frame="box" bordercolor="#C1C1C1" summary="Procedure IML: d">
<colgroup>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">d</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">3</td>
<td class="r data">1</td>
</tr>
</tbody>
</table>
</div>
</div>
<br>
<table class="systitleandfootercontainer" width="100%" cellspacing="1" cellpadding="1" rules="none" frame="void" border="0" summary="Page Layout">
<tbody><tr>
<td class="c systemtitle">dimension(y)</td>
</tr>
</tbody></table><br>
<div>
<div align="center">
<table class="table" cellspacing="0" cellpadding="5" rules="all" frame="box" bordercolor="#C1C1C1" summary="Procedure IML: d">
<colgroup>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="c b header" colspan="2" scope="colgroup">d</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">3</td>
<td class="r data">1</td>
</tr>
</tbody>
</table>
</div>
</div>
<br>
<table class="systitleandfootercontainer" width="100%" cellspacing="1" cellpadding="1" rules="none" frame="void" border="0" summary="Page Layout">
<tbody><tr>
<td class="c systemtitle">a = x + y</td>
</tr>
</tbody></table><br>
<div>
<div align="center">
<table class="table" cellspacing="0" cellpadding="5" rules="all" frame="box" bordercolor="#C1C1C1" summary="Procedure IML: a">
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
</div>
</div>
<br>
</div>

R:
```
> ls()
[1] "x" "y"
> rm(x,y)
> ls()
character (0)
```

No parallel SAS/IML codes for `ls` and `rm` have been found yet.

### Page 44

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

```
