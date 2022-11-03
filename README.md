
# RULER

<img src='img/lib.png' width=150 align=right>
#	ruler.lua	

## Lib	
### Lists	

| What | Notes |
|:---|:---|
| <tt>copy(t:`tab`) &rArr;  t</tt> |  return a deep copy of `t. |
| <tt>keys(t:`tab`) &rArr;  t</tt> |  sort+return `t`'s keys (ignore things with leading `_`) |


### Strings to things	

| What | Notes |
|:---|:---|
| <tt>coerce(s:`str`) &rArr;  any</tt> |  return int or float or bool or string from `s` |
| <tt>csv(sFilename:`str`, fun:`fun`) &rArr;  nil</tt> |  call `fun` on rows (after coercing cell text) |


### Meta	

| What | Notes |
|:---|:---|
| <tt>kap(t:`tab`,  fun:`fun`) &rArr;  t</tt> |  map function `fun`(k,v) over list (skip nil results)  |
| <tt>map(t:`tab`,  fun:`fun`) &rArr;  t</tt> |  map function `fun`(v) over list (skip nil results)  |


### Printing	

| What | Notes |
|:---|:---|
| <tt>fmt(sControl:`str`, ...) &rArr;  str</tt> |  emulate printf |
| <tt>oo(t:`tab`) &rArr;  t</tt> |  print `t`'s string (the one generated by `o`) |
| <tt>o(t:`tab`,   seen:`str`?) &rArr;  str</tt> |  table to string (recursive) |


### Random numbers	

| What | Notes |
|:---|:---|
| <tt>rand(nlo:`num`, nhi:`num`) &rArr;  num</tt> |  return float from `nlo`..`nhi` (default 0..1) |
| <tt>rint(nlo:`num`, nhi:`num`) &rArr;  int</tt> |  returns integer from `nlo`..`nhi` (default 0..1) |
| <tt>srand(n:`num`) &rArr;  nil</tt> |  reset random number seed (defaults to 937162211)  |


### Objects	

| What | Notes |
|:---|:---|
| <tt>obj(s:`str`) &rArr;  t</tt> |  create a klass and a constructor + print method |


### Main control	

| What | Notes |
|:---|:---|
| <tt>cli(t:`tab`) &rArr;  t</tt> |  alters contents of options in `t` from the  command-line |
| <tt>run(fun:`fun`) &rArr; x</tt> |  reset seed; call `fun`; afterwards, reset config |
| <tt>NUM:discretize(n:`num`) &rArr;  num</tt> |  discretize `Num`s,rounded to (hi-lo)/bins |


## Start up	
