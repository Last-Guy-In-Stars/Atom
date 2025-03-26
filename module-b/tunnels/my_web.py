from socket import *  # Импорт модуля (не рекомендуется в продакшене)

def createServer():
    # Создаем TCP-сокет
    serversocket = socket(AF_INET, SOCK_STREAM)
    
    try:
        # Привязываем сокет к адресу и порту
        serversocket.bind(('localhost', 9000))
        # Начинаем слушать соединения (максимум 5 в очереди)
        serversocket.listen(5)
        
        print("Сервер запущен на http://localhost:9000")
        
        while True:  # Бесконечный цикл обработки подключений
            try:
                # Принимаем клиентское подключение
                clientsocket, address = serversocket.accept()
                print(f"Подключение от {address}")
                
                # Читаем запрос (опционально)
                request = clientsocket.recv(1024).decode()
                print(f"Запрос:\n{request}")
                
                # Формируем корректный HTTP-ответ
                response = (
                    "HTTP/1.1 200 OK\r\n"
                    "Content-Type: text/html; charset=utf-8\r\n"
                    "\r\n"  # Обязательная пустая строка между заголовками и телом
                    "<html><body><h5>hi</h5></body></html>\r\n"
                ).encode('utf-8')  # Кодируем ответ в байты
                
                # Отправляем ответ
                clientsocket.sendall(response)
                
            except Exception as e:
                print(f"Ошибка при обработке клиента: {e}")
            finally:
                # Корректно закрываем соединение с клиентом
                clientsocket.shutdown(SHUT_WR)
                clientsocket.close()
                
    except KeyboardInterrupt:
        print("\nСервер остановлен")
    except Exception as e:
        print(f"Критическая ошибка: {e}")
    finally:
        serversocket.close()

createServer()