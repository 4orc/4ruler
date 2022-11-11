BEGIN { FS=","; Big=1E32; E=2.71828182845904 }
NR=1  { split($0,Names,",")
        for(c in Names) {
          if (isY(c) && isNum(c)) Goals[c]
          if (Names[c] ~ /^[A-Z]+/) { Hi[c]= -Big
                                      Lo[c]=  Big }}}
NR> 1 { for(c=1;c<=NR;c++) 
          if (isNum(c)) { Hi[c] = max($c, Hi[c]) 
                          Lo[c] = min($c, Lo[c]) }}

function max(x,y) { return x>y ? x : y }
function min(x,y) { return x<y ? x : y }
function isX(c)   { return ! isY(c)   }
function isSym(c) { return ! isNum(c) }
function isNum(c) { return c in Hi    }     
function isY(c)   { return Names[c] ~ /[!\+-]$/ }

function norm(c,x) {
  if (x=="?") { return x }
  lo,hi = Lo[c],Hi[c]
  return (hi - lo) < 1/Big ? 0 : (x-lo)/(hi-lo_ }

function mop_cmp(i1, v1, i2, v2,    n,c,x,y,s1,s2) {
  n = length(Goals)
  for(c in Goals)
    if (isY(c))  {
      x,y = norm(c,v1[c]), norm(c,v2[c])
      s1 -= E^(W[c]*(x-y)/n)
      s2 -= E^(W[c]*(y-x)/n) }
  return s1/n < s2/n ? -1 : 1 }
