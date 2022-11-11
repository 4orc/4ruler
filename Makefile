-include ../etc/Makefile


README.md: ../4readme/readme.lua ruler.lua ## update readme
	printf "\n<img src='img/ruler.jpg' width=200 align=right>\n\n" > README.md
	lua $< ruler.lua >> README.md

# changes to 3 cols and 101 chars/line
~/tmp/r1.pdf: r1  ## .lua ==> .pdf
	mkdir -p ~/tmp
	cp r1 r1.lua
	echo "pdf-ing r1 ... "
	a2ps                 \
		-Br                 \
		--chars-per-line 90 \
		--file-align=fill      \
		--line-numbers=1        \
		--borders=no             \
		--pro=color               \
		--left-title=""            \
		--pretty-print="$R/etc/lua.ssh" \
		--columns  3                 \
		-M letter                     \
		--footer=""                    \
		--right-footer=""               \
	  -o	 r1.ps r1.lua
	ps2pdf r1.ps ~/tmp/r1.pdf; rm r1.ps r1.lua
	open ~/tmp/r1.pdf

# changes to 3 cols and 101 chars/line
~/tmp/%.pdf: %.lua  ## .lua ==> .pdf
	mkdir -p ~/tmp
	echo "pdf-ing $@ ... "
	a2ps                 \
		-BR                 \
		--chars-per-line 100 \
		--file-align=fill      \
		--line-numbers=1        \
		--borders=no             \
		--pro=color               \
		--left-title=""            \
		--pretty-print="$R/etc/lua.ssh" \
		--columns  2                 \
		-M letter                     \
		--footer=""                    \
		--right-footer=""               \
	  -o	 $@.ps $<
	ps2pdf $@.ps $@; rm $@.ps
	open $@

