# Структура проекта
ALU.v - Арифметико-логическое устройство

queue_with_controller.v - Контроллер очереди

calculator.v - Основной модуль калькулятора

calculator_test.v - Тестовый модуль для верификации

# Сборка проекта
Для сборки проекта необходимо компилировать следующие файлы в указанном порядке:

bash
Пример команды для компиляции в Icarus Verilog
iverilog -o calculator ALU.v queue_with_controller.v calculator.v

Для запуска тестов
iverilog calculator_test.v ALU.v queue_with_controller.v calculator.v



o   