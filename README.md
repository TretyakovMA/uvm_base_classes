# UVM Base Classes

[![UVM](https://img.shields.io/badge/UVM-1.2-blue.svg)](https://www.accellera.org/community/uvm)
[![SystemVerilog](https://img.shields.io/badge/SystemVerilog-2023-blue.svg)](https://standards.ieee.org/ieee/1800/7743/)

Набор **переиспользуемых параметризованных базовых классов** для UVM-тестбенчей.  
Предназначен для использования как **git submodule** в других проектах.

## ✨ Особенности

- **base_agent** — полностью параметризованный агент (активный/пассивный, с/без монитора)
- **base_driver** + **base_monitor** — единая инфраструктура с автоматической обработкой сброса (`reset_sensitive`)
- **base_agent_config** — единая конфигурация через `uvm_config_db`
- **custom_report_server** — красивый цветной вывод + автоматическое логирование в `sim_log_*.log` и `errors.log`
- **custom_report_macros** — удобные макросы для отчётов (`START_TEST`, `RES_SUC`, `GET_TR_STR` и т.д.)
- **void_driver / void_monitor** — позволяют использовать параметры по умолчанию в `base_agent`
- Поддержка `DPI-C` для получения реального времени старта симуляции
- Чёткое разделение фаз и корректная работа с objections в мониторе

## 📁 Структура проекта

```text
uvm_base_classes|
                ├── custom_report_macros.sv
                ├── custom_report_server.sv
                ├── void_classes.sv
                ├── base_agent_config.sv
                ├── base_driver.sv
                ├── base_monitor.sv
                ├── base_agent.sv
                ├── c_functions.c                ← DPI-C функция времени старта
                ├── base_classes_pkg.sv          ← главный пакет (include всех файлов)
                └── README.md
```

## 🚀 Установка как submodule

```bash
# В корне вашего проекта
git submodule add https://github.com/ВАШ_НИК/uvm-base-classes.git tb/uvm_base_classes
git submodule update --init --recursive
```

### Подключение в вашем проекте

В вашем основном пакете:

```systemverilog

package my_project_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "uvm_base_classes/base_classes_pkg.sv"

    // ваш код...
endpackage
```

Не забудьте добавить путь в `+incdir` при компиляции:

```bash
+incdir+tb/uvm_base_classes
```

## 🔧 Основные возможности и настройки

| Макрос / define              | Что делает                                      |
|------------------------------|-------------------------------------------------|
| `USE_CUSTOM_REPORT_SERVER`   | Включает красивый report server                 |
| `USE_C_FUNCTIONS`            | Включает DPI-C функцию времени старта           |

**Пример конфигурации агента:**

```systemverilog
base_agent_config #(my_if) cfg = base_agent_config#(my_if)::type_id::create("cfg");
cfg.vif          = my_if_h;
cfg.is_active    = UVM_ACTIVE;
cfg.has_monitor  = 1;
cfg.reset_sensitive = 1;

uvm_config_db#(base_agent_config#(my_if))::set(null, "*", "agent_config", cfg);
```

## 📌 Рекомендации по использованию

- Все производные агенты наследуйте от `base_agent`.
- Для активных агентов **обязательно** переопределите `set_sequencer_name()`.
- Используйте `base_driver` и `base_monitor` вместе — они работают по одной архитектуре.
- Для драйвера/монитора, контролирующего сброс ставьте `reset_sensitive = 0`.

## Автор

Mikhail Tretyakov
