**Задача 1:**

Дизассемблировать исполняемые файлы в Linux и определить, сколько раз в двоичном коде /bin/grep встречается вызов функции malloc.


Можно использовать консольную утилиту objdump.

**1. Вариант. Дизассемблировать всё.**

Применть операцию в терминале: objdump -D /bin/grep | grep malloc

Получим результат:

0000000000004440 <malloc@plt>:

    4440:	ff 25 62 ca 02 00    	jmpq   *0x2ca62(%rip)        # 30ea8 <malloc@GLIBC_2.2.5>

   1b85f:	e8 dc 8b fe ff       	callq  4440 <malloc@plt>

   1bdae:	e8 8d 86 fe ff       	callq  4440 <malloc@plt>

   1c695:	e8 a6 7d fe ff       	callq  4440 <malloc@plt>

   1c935:	e8 06 7b fe ff       	callq  4440 <malloc@plt>

   20b1d:	e8 1e 39 fe ff       	callq  4440 <malloc@plt>

   20c44:	e8 f7 37 fe ff       	callq  4440 <malloc@plt>

   20c64:	e8 d7 37 fe ff       	callq  4440 <malloc@plt>

   20d7f:	e8 bc 36 fe ff       	callq  4440 <malloc@plt>

   20dc5:	e8 76 36 fe ff       	callq  4440 <malloc@plt>

   21be3:	e8 58 28 fe ff       	callq  4440 <malloc@plt>

   2218c:	e8 af 22 fe ff       	callq  4440 <malloc@plt>

   226b7:	e8 84 1d fe ff       	callq  4440 <malloc@plt>

   22a0f:	e8 2c 1a fe ff       	callq  4440 <malloc@plt>

   22e45:	e8 f6 15 fe ff       	callq  4440 <malloc@plt>

   22ee3:	e8 58 15 fe ff       	callq  4440 <malloc@plt>

   22fee:	e8 4d 14 fe ff       	callq  4440 <malloc@plt>

   230ce:	e8 6d 13 fe ff       	callq  4440 <malloc@plt>

   2325d:	e8 de 11 fe ff       	callq  4440 <malloc@plt>

   2380e:	e8 2d 0c fe ff       	callq  4440 <malloc@plt>

   238b9:	e8 82 0b fe ff       	callq  4440 <malloc@plt>

Всего 21 запись.

При этом:

- malloc@plt указывает на вызов функции malloc вероятнее всего внутри libc

- malloc@GLIBC_2.2.5 скорее всего указывает на вызов функции malloc из libc внтури grep


**2. Вариант. Отобразить символы.**


Применть операцию в терминале: objdump -T /bin/grep | grep malloc

Получим результат :

0000000000000000      DF *UND*  0000000000000000  GLIBC_2.2.5 malloc

Всего одна запись, которая указывает на вызов функции malloc из libc внтури grep


**Вывод**


- Один раз вызывается malloc внутри grep и используется GLIBC_2.2.5.

- 20 раз malloc вызывается внутри libc.




**Задача 2:**

Скрипт, который принимает на вход класс-файл и возвращает список классов, которые упоминаются во всех инструкциях invokevirtual, встречающихся в его байткоде.

Описание:

Для дизассемблировывания байт кода можно использовать утилиты:

Java:

    javap -c позволяет дизассемблировать код и получить инструкции, содержащие байт-коды Java, для каждого из методов класса. javap входит в openjdk.

Используя утилиту, можно получить упоминания инструкций new, return, invokevirtual, invokespecial и других.

Инструкция invokevirtual указывает на вызовы методов данного или других классов.

Скрпит ReturnInvokeVirtual находит все строки с инструкцией invokevirtual, приводит строку к читаемому виду и выводит результат.

В качестве результата выводится список используемых классов.

При этом скрипт делает постобработку после команды javap -p -c. Исключаются приватные методы и отбрасываются вызываемые методы, остаются только классы, при этом исключается дублирование. Например: java/lang/String

Cкрипт можно вызвать командой ./ReturnInvokeVirtual.sh и передать class файл

Примеры:

    Корректный небольшой файл:

./ReturnInvokeVirtual.sh Brainfuck.Lexer.class

Результат:

java/lang/String

    Корректный файл с активным использованием классов:

./ReturnInvokeVirtual.sh ThreadPoolTests.class

Результат:

java/lang/Integer

java/lang/Object

java/util/concurrent/CountDownLatch

java/util/concurrent/ExecutionException

org/assertj/core/api/AbstractBooleanAssert

org/assertj/core/api/AbstractComparableAssert

org/assertj/core/api/AbstractIntArrayAssert

org/assertj/core/api/AbstractIntegerAssert

org/assertj/core/api/AbstractThrowableAssert

org/assertj/core/api/ListAssert

    Некорректный файл

./ReturnInvokeVirtual.sh test.txt

Результат:

Error: incorrect input file

