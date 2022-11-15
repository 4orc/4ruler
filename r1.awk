#!/usr/bin/env gawk -f
@namespace "r1"

## stats
BEGIN { Id=0; FS=","; Big=1E32; E=2.71828182845904 }
      { gsub(/[ \t]+/,"") }

function has(i,k,f)       { list(i,k)  if(f) @f(i) }
function haS(i,k,f,x)     { list(i,k); @f(i,x)     }
function hAS(i,k,f,x,y)   { list(i,k); @f(i,x,y)   }
function HAS(i,k,f,x,y,z) { list(i,k); @f(i,x,y,z) }

function have(i,f,          k) { k=1+length(i); has(i,k,f);       return k }
function havE(i,f,x,        k) { k=1+length(i); has(i,k,f,x);     return k }
function haVE(i,f,x,y,      k) { k=1+length(i); has(i,k,f,x,y);   return k }
function hAVE(i,f,x,y,z,    k) { k=1+length(i); has(i,k,f,x,y,z); return k }

function list(i,k) { 
  split("",i,"") 
  if (k != "") { i[k][k]; del i[k][k] }} # a can accept sublists

function csv(i,file,   n) {
  DATA(i)
  while((getline < file) > 0) { split(s,i,","); add(i,++n,a) }  
  close(file) }

function add(i,n,a)  { n==1 ? header(i,a) : data(i,a) }
function header(i,a) {
  for(c in a) { 
    i["names"][c] = x = a[c]
    haVE(i["cols"], x ~ /^[A-Z]+/ ? "NUM" : "SYM",c,a[c]) }}

function DATA(i) {
  has(i,"cols")
  has(i,"rows") }

function SOME(i, max) {
  i["n" ]= 0
  i["ok"]= 1 
  has(i,"has")
  i["max"] = max ? max : 256 }

function NUM(i,n,s) {
  i["n"  ]= 0
  i["at" ]= n == "" ? 0 "" : n
  i["txt"]= s == "" ? "" : s
  i["hi" ]= -Big; i["lo"] = Big
  i["w"  ]= i["txt"] ~ /-$/ ? -1 : 1 
  has(i,"some","SOME") }

function SYM(i,n,s) {
  i["n"  ]= 0
  i["at" ]= n == "" ? 0 "" : n
  i["txt"]= s == "" ? "" : s
  has(i,"some") }

function data(i,a,    x,n) { 
  n = 1 + length(i["rows"])
  for(c in a) {
    x = a[c] 
    if(c in i["hi"]) {
      x = x + 0
      i["lo"][c] = min(x, i["lo"][c])
      i["hi"][c] = max(x, i["hi"][c]) }
    i["rows"][n] = x }}

function some(i) { list(i,"has"); i["ok"] = 0 }
function 

function max(x,y) { return x>y ? x : y }
function min(x,y) { return x<y ? x : y }
function isNum(x) { return x ~ /^[A-Z]+/ }
function isY(x)   { return x ~ /[!\+-]$/ }

function help(file) {
   while((getline < file) > 0) { if (sub(/^## /,"  ",$0)) print $0 }; close(file) }

function coerce(x,  y) { y=x+0; return x==y ? y : x }

function set(a,out) {if (a[1]~/##/ && sub(/^--/,"",a[3])) out[a[3]]=coerce(a[length(a)])}

## -h --hasd asdas  = 33
## -f --file afe = sadas

function sd(a,    i,n,d,mu,m2) {
  for(i in a) { n++; d = a[i] - mu; mu += d/n; m2 += d*(a[i]-mu) }
  return n<2 ? 0 : (m2/(n-1))^.5 }

function lines(file,fun,payload,sep,    s,a) {
   while((getline s < file) > 0) { split(s,a,sep ? sep : " "); @fun(a,payload) }
   close(file) }

fBEGIN {lines("r1.awk","set",a); for(i in a) print(i,typeof(a[i]), a[i]) ;
       help("r1.awk")}

function norm(c,x) {
  if (x=="?") return x
  return (Hi[c] - Lo[c]) < 1/Big ? 0 : (x-Lo[c])/(Hi[c]-Lo[c]) }

function goals_cmp(i1, v1, i2, v2,    n,c,x,y,s1,s2) {
  n = length(W)
  for(c in W)
    if (isY(c))  {
      x = norm(c,v1[c])
      y = norm(c,v2[c])
      s1 -= E^(W[c]*(x-y)/n)
      s2 -= E^(W[c]*(y-x)/n) }
  return s1/n < s2/n ? -1 : 1 }

function discretize(c,x) {
  if (!isNum(c)) return x
  w = (Hi[c] - Lo[c])/16
  return  w * int(x - Lo[c]/w) }

function BIN(a,v,x,y) { 
  a[v]["lo"]=x
  a[v]["hi"]=x
  a[v]["ys"][y]=0 }

function bin(a,x,y) {
  a["lo"] = min(a["lo"],x)
  a["hi"] = min(a["hi"],x) 
  a["ys"][y]++ }

# END {
#   n=asort(DATA,DATA,"goals_cmp")
#   for(c in Names)
#    if (!isY(c)) {
#      of(Bins,c)
#      for(r=1;r<=n;r++) {
#        y = r<(n^.5)
#        x = Data[r][c]
#        if (x!="?") {
#          v= discretize(c,x) 
#          if (!(v in Bins[c])) bin(Bins[c],v,x,y)
#          binAdd(Bins[c][v],x,y) }}}}
