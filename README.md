**Задача 1**

Как в Linux дизассемблировать исполняемые файлы. Определите, сколько раз в двоичном коде /bin/grep встречается вызов функции malloc.


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


Вероятнее всего вывод следующий:

- Один раз вызывается malloc внутри grep и используется GLIBC_2.2.5.

- 20 раз malloc вызывается внутри libc.
