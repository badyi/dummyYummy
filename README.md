# dummyYummy

<p align="center">
    <img src="https://i.postimg.cc/SKn5Y5RR/ice.png">
</p>

С приложением dummyYummy вы можете искать иссдедовать случайные рецепты или же искать их по названию, по ингредиентам, также вы можете искать рецепты по ингредиентам, а понравившиеся сохранить на устройство 

## App scenarios
### First Launch
При первом запуске вы увидите небольшой guide по приложению

[![ezgif-com-video-to-gif.gif](https://i.postimg.cc/2yZh4jY3/ezgif-com-video-to-gif.gif)](https://postimg.cc/303khTdH)

### **Browes recipes tab**
Здесь вы можете увидеть случайные 100 рецептов

[![5i3cob.gif](https://i.postimg.cc/V6LRpZ01/5i3cob.gif)](https://postimg.cc/XZmdy8gD)

Вы можете обновить рецепты и появятся другие 100 случайных рецептов

[![5i3cah.gif](https://i.postimg.cc/4y2FWkWr/5i3cah.gif)](https://postimg.cc/fSXKbFnK)

Также вы можете искать рецепты по названию

[![5i3d24.gif](https://i.postimg.cc/hPp734bJ/5i3d24.gif)](https://postimg.cc/SJYsnhPq)

У вас есть возможность открыть Detail по конкретному рецепту

[![5i3e8q.gif](https://i.postimg.cc/ZKd56Tst/5i3e8q.gif)](https://postimg.cc/sv3zrRRw)

Вы можете делиться ссылками на рецепты со своими друзьями

[![5i3eu9.gif](https://i.postimg.cc/d3QSwt77/5i3eu9.gif)](https://postimg.cc/S25GG4fq)

### What's in the fridge? tab

Здесь вы можете найти ингредиенты, которые у вас имеются, и найти по ним рецепты

[![5i3ki2.gif](https://i.postimg.cc/d1pWbPMd/5i3ki2.gif)](https://postimg.cc/5Y5qzr2N)

### Favorite tab

Здесь хранятся ваши лайкнутые рецепты, которые сохранены на ваше устройство 

[![5i3lcm.gif](https://i.postimg.cc/Fs39nhty/5i3lcm.gif)](https://postimg.cc/4m4kYkxy)

### Detail

В этом модуле у вас есть возможность смотреть различные характеристики, ингредиенты, а также пошаговые инструкции (если они имеются)

[![5i3lyy.gif](https://i.postimg.cc/WzP2sygF/5i3lyy.gif)](https://postimg.cc/7GmvVmBw)

## Детали реализации

### Deployment Target: iOS 13

### Архитектура приложения

Архитектура **MVP+Coordinator+MicroServices**.<br>
По ссылке вы можете рассмотреть miro board с примечаниями - https://miro.com/app/board/o9J_l5QlKD0=/

[![2021-07-30-19-31-59.png](https://i.postimg.cc/mhWh6wbR/2021-07-30-19-31-59.png)](https://postimg.cc/1VM98DnY)

### Навигация в приложении

Навигация между модулями реализована при помощи паттерна **Coordinator**.<br>
По ссылке вы можете рассмотреть miro board с примечаниями - https://miro.com/app/board/o9J_l5QlKD0=/

[![2021-07-30-18-51-52.png](https://i.postimg.cc/VvQmRhNs/2021-07-30-18-51-52.png)](https://postimg.cc/njkyV07N)

### Cервисы 

- **NetworkService.** У каждого модуля, в котором необходима загрузка из сети есть свой network service.<br>
  Для выполнения запросов NetworkService использует networkHelper, который исполняет запрос в сеть и возвращает ответ сервера сервису. <br>
  Каждый запрос реализует протокол Сanceletion, чтобы мы могли отменять не актуальные запросы в сеть такие как например загрузка картинки для ячейки, которая уже не отображается на экране. <br>
  Также для Networing'a мы используем класс Resource, который хранит в себе информацию о запросе (url, httpMethod, headers), а также парсит полученный данные в необходимую модель данных.
- **DataBaseService.** Сервис работы с базой данных. Использует shared instance CoreDataStack для получения и записи данных.
- **FileSystemService.** Сервис для работы с файловой системой. Использует FileManager для записи фотографий по уникальному ключу, также может доставать фотографии по уникальному ключу.

### Кастомная анимация. Shimmer animation

Во время загрузки, ячейки анимируются.

[![5i3z8j.gif](https://i.postimg.cc/wMxcWLk1/5i3z8j.gif)](https://postimg.cc/FdqLzf8v)

### UserDefaults

Используется для хранения информации об первом запуске приложения. Если приложения запущено в первый раз, то сначала пользователю будет показан guide по приложению.

### CocoaPods

- **Swiftlint**
- **SnapshotTesting**

### All tests code coverage

[![2021-07-30-20-53-32.png](https://i.postimg.cc/g0jTkwLF/2021-07-30-20-53-32.png)](https://postimg.cc/JywqpzQP)

### Unit-Tests code coverage

[![2021-07-30-20-35-35.png](https://i.postimg.cc/QdPqmFPb/2021-07-30-20-35-35.png)](https://postimg.cc/ts3PC49Z)

### API link

- **Thanks to spoonacular** - https://spoonacular.com/food-api

## Subscribe, Like & Share.

![Alt Text](https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif)
