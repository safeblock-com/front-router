# front-router

Решаемая проблема - https://t.me/c/2182995616/18/17144

Веб-сервер который занимается роутингом пользовательских запросов на
исторические версии фронтовых приложений.

Этот репозиторий хранит Dockerfile для построения образа на основе nginx.

# Как это работает?

nginx в этом репозитории работает как reverse proxy и имеет 3 upstream сервера,
с разными версиями приложения. Файлы не найденные в 1-м upstream сервере берутся
из 2-го, не найденный во 2-м, берутся из 3-го.

# Разработка, проверка работоспособости:

Билдит, запускает контейнер:

```sh
make
```

# Тестирование и отладка:

```sh
make test
```

Проверить доступ к определённому хосту:

```sh
PROXY_HOST=ethereum.node.safeblock.work PROXY_PROTO=http make
PROXY_HOST=ethereum.nodevi.com PROXY_PROTO=https make
```

# Сборка и публикация релизного образа

Через [релизы в github](https://github.com/safeblock-com/ankira/releases/new)

# Подобные проекты

* https://github.com/chainstacklabs/eth-proxy
