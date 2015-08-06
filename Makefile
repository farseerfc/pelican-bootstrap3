all: less trans

less: static/css/bootstrap.min.css static/css/material.min.css

static/css/bootstrap.min.css: static/bootstrap/*.less static/bootstrap/mixins/*.less
	lessc -x static/bootstrap/bootstrap.less > static/css/bootstrap.min.css

static/css/material.min.css: static/material/*.less
	lessc -x static/material/material.less > static/css/material.min.css

static/css/ripples.min.css: static/material/ripples.less
	lessc -x static/material/ripples.less > static/css/ripples.min.css

TRANS_TARGET=$(shell find -iname "messages.po")

trans: $(patsubst %/messages.po,%/messages.mo,$(TRANS_TARGET))

%/messages.mo: %/messages.po
	opencc -c opencc-t2s.json -i translations/zh_HK/LC_MESSAGES/messages.po -o translations/zh_CN/LC_MESSAGES/messages.po
	py3babel compile --directory translations/ --domain messages

%/messages.po: messages.pot
	py3babel update --input-file messages.pot --output-dir translations/ --domain messages

messages.pot: templates/*.html templates/includes/*.html babel.cfg
	py3babel extract --mapping babel.cfg --output messages.pot ./

.PHONY: less all trans
