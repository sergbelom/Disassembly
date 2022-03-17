**Задача 2**

Разберитесь, как дизассемблировать байткод JVM.

Напишите программу или скрипт, которая принимает на вход класс-файл и возвращает список классов, которые упоминаются во всех инструкциях invokevirtual, встречающихся в его байткоде. 

**Описание**

Для дизассемблировывания байт кода можно использовать утилиты:

Java:

- *javap -c* позволяет дизассемблировать код и получить инструкции, содержащие байт-коды Java, для каждого из методов класса. javap входит в openjdk.

Используя утилиту, можно получить упоминания инструкций new, return, invokevirtual, invokespecial и других.

C#:

- dotPeek, ILSpy

**Решение через скрипт, с использованием *javap* утилиты**

Инструкция invokevirtual указывает на вызовы методов данного или других классов.

Скрпит ReturnInvokeVirtual находит все строки с инструкцией invokevirtual, приводит строку к читаемому виду и выводит результат.

В качестве результата выводится список используемых классов.

При этом скрипт делает постобработку после команды *javap -p -c*. Исключаются приватные методы и отбрасываются вызываемые методы, остаются только классы, при этом исключается дублирование. Например: `java/lang/String`

Cкрипт можно вызвать командой ./ReturnInvokeVirtual.sh и передать class файл

Примеры:

1. Корректный небольшой файл:

`./ReturnInvokeVirtual.sh Brainfuck.Lexer.class`

Результат:

`java/lang/String`

2. Корректный файл с активным использованием классов:

`./ReturnInvokeVirtual.sh ThreadPoolTests.class`

Результат:

`java/lang/Integer`

`java/lang/Object`

`java/util/concurrent/CountDownLatch`

`java/util/concurrent/ExecutionException`

`org/assertj/core/api/AbstractBooleanAssert`

`org/assertj/core/api/AbstractComparableAssert`

`org/assertj/core/api/AbstractIntArrayAssert`

`org/assertj/core/api/AbstractIntegerAssert`

`org/assertj/core/api/AbstractThrowableAssert`

`org/assertj/core/api/ListAssert`

3. Некорректный файл

`./ReturnInvokeVirtual.sh test.txt`

Результат:

`Error: incorrect input file`
