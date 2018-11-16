langs = "en_US,ja_JP,zh_HK,zh_CN".split(',')

trans_source = map(lambda x: 'translations/'+x+'/LC_MESSAGES/messages.po', langs)
trans_target = list(map(lambda x: x[:-2]+"mo", trans_source))

Alias("trans", trans_target)

NoClean(trans_source)
Precious(trans_source)
NoClean('messages.pot')
Precious('messages.pot')

bootstrap = Command('static/css/bootstrap.min.css',
                    Glob('static/bootstrap/*.less') +
                    Glob('static/bootstrap/mixins/*.less'),
                    'lessc -x static/bootstrap/bootstrap.less > ${TARGET}')

material = Command('static/css/material.min.css',
                   Glob('static/material/*.less'),
                   'lessc -x static/material/material.less > ${TARGET}')

ripples = Command('static/css/ripples.min.css', 'static/material/ripples.less',
                  'lessc -x static/material/ripples.less > ${TARGET}')

Command(trans_target, trans_source,
        ["opencc -c opencc-t2s.json -i translations/zh_HK/LC_MESSAGES/messages.po -o translations/zh_CN/LC_MESSAGES/messages.po",
         "pybabel compile --directory translations/ --domain messages"])

Command(trans_source, "messages.pot",
        "pybabel update --input-file messages.pot --output-dir translations/ --domain messages")

Command('messages.pot',
        Glob('templates/*.html') +
        Glob('templates/includes/*.html') +
        ["babel.cfg"],
        'pybabel extract --mapping babel.cfg --output messages.pot ./')

Alias("less", [bootstrap, material, ripples])
Default("less", "trans")
