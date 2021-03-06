Приветствую!

В предыдущей [статье](https://habrahabr.ru/post/281583) я писал о [SparrowHub](https://sparrowhub.org) - репозиторий готовых утилит для системного администрирования. Что же время прошло, и теперь хочется рассказать о том КАК разрабатывать эти самые утилиты и загружать их на SparrowHub для повторного использования кем-либо.

<habracut/>


Прежде чем показать конкретный пример написания плагина, хочу немного раскрыть  идеологию фреймворка Sparrow на котором собственно и разрабатываются скрипты.

Во-первых Sparrow не навязывает какого-то жесткого DSL для разработки скриптов. У вас есть на выбор три языка, поддерживаемых Sparrow:

* Perl 
* Ruby
* Bash

Таким образом, вы просто пишите обычный скрипт, который делает нужную вам работы и "оборачиваете" его в плагин, и вуаля - он готов к загрузке на SparrowHub и для повторного использования. Ну , я немножко упростил, не совсем конечно так. Разрабатывая скрипт вы  все же придерживаетесь некоторых соглашений ( например на именования скриптовых файлов и т.д. ) для того что бы ваша утилита могла быть упакована в плагин в sparrow формате.

Другой особенностью Sparrow плагинов является встроенная система тестирования работы скриптов. Встроенная, потому что из коробки у вас есть возможность совершить дополнительные проверки работы скрипты, кроме банального кода завершения. Данная система проверок в ряде случаев может оказаться очень полезной. Детали станут ясны на конкретном примере.

Ну и третья, связанная с предыдущей особенность Sparrow плагинов, это то, что результат их работы выводится в [TAP](https://en.wikipedia.org/wiki/Test_Anything_Protocol) формате. В двух словах TAP - специальный протокол ( плюс формат вывода ), разработанный для тестирования программных модулей, он является стандартным для написания unit тестов в Perl, но не привязан к конкретному языку программирования и имеет поддержку во многих системах.

Таким, образом в Sparrow предпринята попытка ( насколько удачная покажет практика ;) ) совместить написание скриптов системного администрирования с системой тестирования работы самих скриптов. Похожие идея можно увидеть в различных системах управления конфигурациями,  например в [chef](https://www.chef.io/chef/) - это [minitest chef handler](https://github.com/chef/minitest-chef-handler) и пожалуй, отчасти   [chef inspec](https://www.chef.io/inspec/)
  


