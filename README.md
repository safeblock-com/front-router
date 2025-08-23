# front-router

[![Test](https://github.com/safeblock-com/front-router/actions/workflows/test.yaml/badge.svg)](https://github.com/safeblock-com/front-router/actions/workflows/test.yaml)

Решаемая проблема - https://t.me/c/2182995616/18/17144

fallback Веб-сервер который занимается роутингом пользовательских запросов на
исторические версии фронтовых приложений.

Этот репозиторий хранит Dockerfile для построения образа на основе nginx.

# Как это работает?

nginx в этом репозитории работает как reverse proxy и использует 3 upstream сервера, передаваемые через переменные окружения в момент старта образа.

Например:

```sh
SERVER0=http://server0:8000
SERVER1=http://server1:8000
SERVER2=http://server2:8000
```

Когда пользователь запрашивает файл он ищется по-порядку в каждом из upstream
пока не найдется нужный.

# Разработка, проверка работоспособости:

Билдит, запускает контейнер:

```sh
make
```

# Тестирование и отладка:

```sh
make test
```
