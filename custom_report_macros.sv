`ifndef CUSTOM_REPORT_MACROS
`define CUSTOM_REPORT_MACROS

    // Глобальный флаг (устанавливается в custom_report_server::new())
    bit g_report_use_color = 1;   // по умолчанию — цвета включены

    // === ЦВЕТНЫЕ ВЕРСИИ ===
    `define START_TEST_STR_COLOR { \
        "\n",{50{"#"}}, \
        "   \033[35mStart Test\033[0m   ", \
        {50{"#"}}\
        }

    `define RES_SUC_STR_COLOR {\
        `RES_STR_1, \
        {49{" "}}, \
        "\033[32mTest successful\033[0m", \
        `RES_STR_2\
    }

    `define RES_FAILD_STR_COLOR {\
        `RES_STR_1, \
        {52{" "}}, \
        "\033[31mTest faild\033[0m", \
        `RES_STR_2\
    }

    `define END_TEST_STR_COLOR {\
        "\n", \
        {51{"#"}},\
        "   \033[35mEnd Test\033[0m   ", \
        {51{"#"}}\
    }

    // === БЕСЦВЕТНЫЕ ВЕРСИИ ===
    `define START_TEST_STR_NC {\
        "\n",{50{"#"}},\
        "   Start Test   ",\
        {50{"#"}}\
    }

    `define RES_SUC_STR_NC {\
        `RES_STR_1, \
        {49{" "}}, \
        "Test successful", \
        `RES_STR_2\
    }

    `define RES_FAILD_STR_NC {\
        `RES_STR_1, \
        {52{" "}}, \
        "Test failed", \
        `RES_STR_2\
    }

    `define END_TEST_STR_NC {\
        "\n", \
        {51{"#"}},\
        "   End Test   ", \
        {51{"#"}}\
    }

    // === ОСНОВНЫЕ МАКРОСЫ — автоматический выбор ===
    `define START_TEST_STR   (g_report_use_color ? `START_TEST_STR_COLOR   : `START_TEST_STR_NC)
    `define RES_SUC_STR      (g_report_use_color ? `RES_SUC_STR_COLOR      : `RES_SUC_STR_NC)
    `define RES_FAILD_STR    (g_report_use_color ? `RES_FAILD_STR_COLOR    : `RES_FAILD_STR_NC)
    `define END_TEST_STR     (g_report_use_color ? `END_TEST_STR_COLOR     : `END_TEST_STR_NC)

    // Вспомогательные макросы (оставляем как есть)
    `define RES_STR_1 {"\n", {51{"!"}}, "   Result   ", {51{"!"}}, "\n"}
    `define RES_STR_2 {"\n", {114{"!"}}}


    `define SEND_TR_STR(TR) {\
        "\n", \
        {46{"*"}}, \
        "   Send transaction   ", \
        {46{"*"}},\
        "\nDriver->DUT:\n", \
        TR.convert2string(), \
        "\n", \
        {114{"*"}}\
    }

    `define GET_TR_STR(TR) {\
        "\n",\
        {47{"*"}},\
        "   Get transaction   ",\
        {46{"*"}},\
        "\nDUT->Scoreboard:\n", \
        TR.convert2string(), \
        "\n", \
        {114{"*"}}\
    }

    `define EXP_TR_STR(TR) {\
        "\n",\
        {44{"*"}},\
        "   Expected transaction   ",\
        {44{"*"}},\
        "\n",\
        TR.convert2string(), \
        "\n", \
        {114{"*"}}\
    }

`endif