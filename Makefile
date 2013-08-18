all:compile typer dialyzer
	
compile:
	./rebar compile

clean:
	./rebar clean

test: all
	./rebar eunit

start:clean compile
	erl -smp +K true +P 1000000 \
		-sname daruma \
		-setcookie daruma_cookie \
		-pa ebin deps/*/ebin \
		-s daruma

# create edoc
doc: all
	./rebar doc
	
# dialyzer
DIALYZER_OPTS = -Wno_behaviours
ERLANG_DIALYZER_APPS = asn1 \
				compiler \
				crypto \
				edoc \
				erts \
				gs \
				hipe \
				inets \
				kernel \
				mnesia \
				observer \
				public_key \
				runtime_tools \
				ssl \
				stdlib \
				syntax_tools \
				tools \
				webtool \
				xmerl

dialyzer: ~/.dialyzer_plt
	dialyzer $(DIALYZER_OPTS) -r ebin

~/.dialyzer_plt:
	dialyzer --build_plt --apps $(ERLANG_DIALYZER_APPS)
	
# typer
typer:
	typer -r src