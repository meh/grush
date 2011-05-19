grush
=====

I DON'T EVEN REMEMBER WHY I MADE THIS, GOSH.

``` ruby
require 'grush'

Grush::Script.new {
  echo 'Hallo'

  (cat 'wat') | (sed 's/cat/dog/') > 'wat.dog'
}
```

That should generate this:
``` bash
(echo 'Hallo')
((cat 'wat') | (sed 's/cat/dog/')) > 'wat.dog'
```

Sounds useless? Maybe, maybe not.
