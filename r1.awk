BEGIN { FS=","; Big=1E32; E=2.71828182845904 }
      { gsub(/[ \t]+/,"") }
NR=1  { split($0,Names,",")
        for(c in Names) {
          if (isY(c) && isNum(c)) {W[c] = Names[c] ~ /-$/ ? -1 : 1
          if (Names[c] ~ /^[A-Z]+/) { Hi[c]= -Big
                                      Lo[c]=  Big }}}
NR> 1 { for(c=1;c<=NR;c++) {
          if (isNum(c)) { $c += 0
                          Hi[c] = max($c, Hi[c]) 
                          Lo[c] = min($c, Lo[c]) }
          Data[NR-1][c] = $c }

function max(x,y) { return x>y ? x : y }
function min(x,y) { return x<y ? x : y }
function isNum(c) { return c in Hi    }     
function isY(c)   { return Names[c] ~ /[!\+-]$/ }

function norm(c,x) {
  if (x=="?") return x
  return (Hi[c] - Lo[c]) < 1/Big ? 0 : (x-Lo[c])/(Hi[c]-Lo[c] }

function goals_cmp(i1, v1, i2, v2,    n,c,x,y,s1,s2) {
  n = length(W)
  for(c in W)
    if (isY(c))  {
      x,y = norm(c,v1[c]), norm(c,v2[c])
      s1 -= E^(W[c]*(x-y)/n)
      s2 -= E^(W[c]*(y-x)/n) }
  return s1/n < s2/n ? -1 : 1 }

function discretize(c,x) {
  if (!isNum(c)) return x
  w = (Hi[c] - Lo[c])/16
  return  w * int((x - Lo(c))/w) }

function malloc(a,i) { a[i][i]; del a[i][1] }
function BIN(a,v,x,y) {
  a[v]["lo"]=x
  a[v]["hi"]=x
  a[v]["ys"][y]=0 }

function bin(a,x,y) {
  a["lo"] = min(a["lo"],x)
  a["hi"] = min(a["hi"],x) 
  a["ys"][y]++ }

END {
  n=asort(DATA,DATA,"goals_cmp")
  for(c in Names)
   if (!isY(c)) {
     malloc(Bins,c)
     for(r=1;r<=n;r++) {
       y = r<(n^.5)
       x = Data[r][c]
       if (x!="?") {
         v= discretize(c,x) 
         if (!(v in Bins[c])) bin(Bins[c],v,x,y)
         binAdd(Bins[c][v],x,y) }}}}
