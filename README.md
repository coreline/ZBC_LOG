# ZCL_LOG — Класс для ведения логов
Ниже представляю описание класса для ведения логов
![First image](https://abap4.ru/wp-content/uploads/2023/10/demo.png)
    
# Создание экземпляра класса
Ниже представлены основные варианты использования конструктора класса. Помимо приведенных вариантов в конструктор можно передать любые параметры структуры BAL_S_LOG. Описание параметров  [подробно описано в статье](https://abap4.ru/basis-application-log.html)
``` abap
  " Сообщения будут храниться в памяти и очистятся после закрытия программы
  DATA(lo_log) = NEW zcl_log( ).

  " Сообщения можно будет записать в БД для просмотра в SLG1, SLGD
  DATA(lo_log) = NEW zcl_log(
      iv_object     = 'ZBAL_OBJECT'     " Имя объекта (настройка в SLG0)
      iv_subobject  = 'ZBAL_SUBOJBECT'  " Имя подобъекта (настройка в SLG0)
  ).

  " Загрузится лог из БД, новые сообщения будут записываться в него же
  DATA(lo_log) = NEW zcl_log(
      iv_log_handle = lv_log_handle     " Ид. номер журнала
  ).
```

# Добавление новых сообщений
Для ведения логов рекомендуется все сообщения выносить в класс сообщений (тр. SE91) и добавлять их в лог через оператор MESSAGE и метод ADD_SYST. Этот подход позволит находить сообщения через журнал использования и добавлять перевод при необходимости. Все методы содержат необязательные параметры, аналогичные полям структуры BAL_S_MSG. Описание параметров [подробно описано в статье](https://abap4.ru/basis-application-log.html). 
``` abap
  DATA(lo_log) = NEW zcl_log( ).

  " Добавление сообщение из системной структуры SY
  MESSAGE e444(00) INTO sy-msgli. " Соединение прервано.
  lo_log->add_syst( ).

  " Добавление сообщение из строки
  lo_log->add_free_text( iv_msgty = rs_c_error iv_text = lv_message ).

  " Добавление сообщения из структуры
  " Параметр структуры может содержать структуры типа
  " - ADD_BAL_S_MSG
  " - ADD_BAL_S_MSGR
  " - ADD_BAPIRET1
  " - ADD_BAPIRET2
  " - ADD_BAPIRETURN
  " - ADD_BDCMSGCOLL
  " - ADD_FIMSG
  " - ADD_MESG
  lo_log->add_struct( ls_return ).

  " Добавление сообщений из таблицы
  " Тип строки таблицы может принимать те же значения что и структура
  " Удобно использовать при получении таблицы сообщений BAPI, BDC и.п.
  lo_log->add_table( lt_return ).

  " Добавление сообщений из другого лога
  lo_log->add_log( lo_other_log ).
```

# Добавление исключений
Для добавления исключений реализовано 2 метода: ADD_EXCEPTION и ADD_EXC. Первый использует BAL_LOG_EXCEPTION_ADD и дает возможность отобразить подробное сообщение. Второй метод позволяет отобразить стек вызовов исключения и локализовать место возникновения. Демонстрация ниже.
``` abap
  DATA(lo_log) = NEW zcl_log( ).
  TRY .
      DATA(lv_kek) = 1 / 0.
    CATCH cx_root INTO DATA(lo_error).
      lo_log->add_exception( lo_error ).
      lo_log->add_exc( lo_error ).
  ENDTRY.
```

Так будет выглядеть журнал сообщений
![](https://abap4.ru/wp-content/uploads/2023/10/ex1.png)
При детализации первого сообщения (метод ADD_EXCEPTION) будет отображаться подробное сообщение
![](https://abap4.ru/wp-content/uploads/2023/10/ex2.png)
При детализации второго (метод ADD_EXC) будет отображаться стек вызовов и место возникновения исключения. Можно будет провалиться в программу и строку где оно возникло.
![](https://abap4.ru/wp-content/uploads/2023/10/ex3.png)

# Отображение сообщений
Для отображения сообщений используется метод DISPLAY. Вывод сообщений реализуется через BAL_DSP_LOG_DISPLAY, для детальной настройки которого можно заполнить необязательный параметр IS_DISPLAY_PROFILE типа BAL_S_PROF. 
``` abap
  DATA(lo_log) = NEW zcl_log( ).

  MESSAGE s042(00) INTO sy-msgli. " Данные сброшены.
  lo_log->add_syst( ).
  TRY.
      DATA(lv_kek) = 1 / 0.
    CATCH cx_root INTO DATA(lo_error).
      lo_log->add_exc( lo_error ).
  ENDTRY.
  lo_log->display( ).
```
![](https://abap4.ru/wp-content/uploads/2023/10/display.png)
Можно также выводить сообщения в модальном окне через метод POPUP. При этом, вызовется BAL_DSP_LOG_DISPLAY с профилем POPUP.
``` abap  ...
  lo_log->popup( ).
```
![](https://abap4.ru/wp-content/uploads/2023/10/popup.png)
Для просмотра сообщений через DISPLAY или POPUP у пользователя должны быть права на SLG1. Если их нет и нужно отобразить сообщения, можно воспользоваться методом MODAL. Данный метод использует функцию MESSAGES_SHOW, которая не требует никаких дополнительных прав. При этом, возможность детализации сообщений пропадет.
``` abap  ...
  lo_log->modal( ).
```
![](https://abap4.ru/wp-content/uploads/2023/10/modal.png)

# Сохранение и поиск сообщений из базы данных
Для сохранения логов в БД необходимо использовать методы SAVE и COMMIT. Для поиска логов из БД следует использовать статичный метод SEARCH, который принимает на вход критерии выбора логов (структура типа BAL_S_LFIL) и возвращает инстанцию лога с найденными сообщениями.
``` abap
  " Сохранение логов в БД
  DATA(lo_log) = NEW zcl_log( 
      iv_object    = 'ZTEST_OBJECT'
      iv_subobject = 'ZTEST_SUBOBJECT'
  ).

  MESSAGE s042(00) INTO sy-msgli. " Данные сброшены.
  lo_log->add_syst( ).
  
  lo_log->save( ).
  lo_log->commit( ).
  
  " Поиск логов
  DATA(lo_log) = zcl_log=>search( VALUE #( 
    object    = VALUE #( ( low = 'ZTEST_OBJECT' ) )
    subobject = VALUE #( ( low = 'ZTEST_SUBOBJECT' ) )
  ) ).
  lo_log->popup( ).
```

# Кумуляция сообщений
Некоторые сообщения отправляются программой несколько раз без предоставления новой информации. Такие сообщения могут быть объединены с помощью необязательного параметра IV_CUMULATE (в каждом методе добавления сообщений). Когда повторяется одно и то же сообщение, новое сообщение не добавляется, счетчик MSG_COUNT для старого сообщения увеличивается.
``` abap
  DATA(lo_log) = NEW zcl_log( ).
  DO 10 TIMES.
    MESSAGE s042(00) INTO sy-msgli. " Данные сброшены.
    lo_log->add_syst( iv_cumulate = abap_true ).
  ENDDO.
  lo_log->popup( ).
```
![](https://abap4.ru/wp-content/uploads/2023/10/cumulate.png)
Если же IV_CUMULATE не передавать или передать в него значение ABAP_FALSE, то будут отображаться все сообщения.
![](https://abap4.ru/wp-content/uploads/2023/10/no_cumulate.png)

# Изменение и удаление и сообщений
Любое сообщение имеет свой номер. Зная данный номер сообщение можно изменить или удалить. Пример ниже сначала добавляет сообщение, затем изменяет его и удаляет.
``` abap
  DATA(lo_log) = NEW zcl_log( ).

  MESSAGE e190(00) INTO sy-msgli. " Изменение пароля невозможно.
  lo_log->add_syst( IMPORTING es_msg_handle = DATA(ls_msg_handle) ).

  MESSAGE s192(00) INTO sy-msgli. " Пароль изменен.
  lo_log->change_from_syst( ls_msg_handle ).

  lo_log->del( ls_msg_handle  ).
```

# Функциональные методы
Все методы класса ZCL_LOG являются функциональными. Это означает что все методы имеют параметр возврата RETURNING. В методах где результат не должен возвращаться, возвращается инстанция текущего лога. Это позволяет выводить сообщения через цепочки вызовов.
``` abap
  MESSAGE s042(00) INTO sy-msgli. " Данные сброшены.
  NEW zcl_log( )->add_syst( )->modal( ).
```

# Дополнительные поля в сообщении
Иногда текст сообщения имеет смысл только в определенном контекста. Добавить контекст можно через параметр IS_CONTEXT, который есть в каждом методе добавления сообщения. Ниже пример добавления поля поставки к сообщению. По значениям данного поля можно также производить поиск через метод SEARCH.
``` abap
  DATA ls_content TYPE vbeln_line.
  DATA ls_context TYPE bal_s_cont.
  FIELD-SYMBOLS <lv_content> TYPE c.

  SELECT SINGLE *
    INTO CORRESPONDING FIELDS OF ls_content
    FROM likp.
  ASSIGN ls_content TO <lv_content> CASTING.

  ls_context-tabname = cl_abap_typedescr=>describe_by_data( ls_content )->get_relative_name( ).
  ls_context-value = <lv_content>.

  MESSAGE e130(vg) INTO sy-msgli. " Документ проведен.
  NEW zcl_log( )->add_syst( is_context = ls_context )->popup( ).
```
![](https://abap4.ru/wp-content/uploads/2023/10/context-1.png)

# Вложение данных к сообщению
В каждом методе добавления сообщений есть необязательный параметр I_ATTACHMENT, который позволяет приложить к сообщению произвольные данные: значение, структура, таблица.
``` abap
  SELECT *
    INTO TABLE @DATA(lt_data)
    FROM spfli.

  DATA(lo_log) = NEW zcl_log( ).

  MESSAGE s094(00) INTO sy-msgli. " Данные были сохранены.
  lo_log->add_syst( i_attachment = lt_data ).
  lo_log->popup( ).
```
При добавлении сообщения с параметром I_ATTACHMENT автоматически появится кнопка "Подробно", при нажатии на которую откроется программа отображения данных.
![](https://abap4.ru/wp-content/uploads/2023/10/attachment.png)
Пример отображения вложенной таблицы 
![](https://abap4.ru/wp-content/uploads/2023/10/table-1024x585.png)
Пример отображения вложенной структуры
![](https://abap4.ru/wp-content/uploads/2023/10/struct.png)

# Произвольная детализация сообщения
Внутренняя механика детализации сообщения [описана в статье](https://abap4.ru/basis-application-log.html). Однако, на практике использовать ее можно только в процедурном стиле. Для ООП программирования детализацию сообщения можно сделать путем имплементации интерфейса ZIF_LOG_DETAILS
Интерфейс ZIF_LOG_DETAILS содержит три метода:<
* CREATE - создание инстанции объекта по ключу
* GET_KEY - возвращает ключ для создания объекта
* SHOW - метод отображения данных

Ниже описан пример для проваливания в FB03
``` abap
  CLASS lcl_details DEFINITION.
    PUBLIC SECTION.
      INTERFACES zif_log_details.
      METHODS constructor
        IMPORTING
          is_bkpf_key TYPE bkpf_key.
  
    PRIVATE SECTION.
      DATA ms_bkpf_key TYPE bkpf_key.
  ENDCLASS.
  
  CLASS lcl_details IMPLEMENTATION.
    METHOD constructor.
      ms_bkpf_key = is_bkpf_key.
    ENDMETHOD.
  
    METHOD zif_log_details~create.
      ro_instance = NEW lcl_details( CONV #( iv_key ) ).
    ENDMETHOD.
  
    METHOD zif_log_details~get_key.
      rv_key = CONV #( ms_bkpf_key ).
    ENDMETHOD.
  
    METHOD zif_log_details~show.
      SET PARAMETER ID 'BUK' FIELD ms_bkpf_key-bukrs.
      SET PARAMETER ID 'GJR' FIELD ms_bkpf_key-gjahr.
      SET PARAMETER ID 'BLN' FIELD ms_bkpf_key-belnr.
      CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.
    ENDMETHOD.
  ENDCLASS.
  
  START-OF-SELECTION.
    PERFORM main.
  
  FORM main.
    DATA ls_bkpf_key TYPE bkpf_key.
    DATA lo_details TYPE REF TO lcl_details.
    DATA lo_log TYPE REF TO zcl_log.
  
    SELECT SINGLE *
      INTO CORRESPONDING FIELDS OF ls_bkpf_key
      FROM bkpf.
  
    lo_log = NEW #( ).
    lo_details = NEW #( ls_bkpf_key ).
  
    MESSAGE s015(ujh0) INTO sy-msgli. " Открыть документ
    lo_log->add_syst( io_details = lo_details ).
    lo_log->popup( ).
  ENDFORM.
```
При нажатии на "Подробно" откроется FB03 с выбранным документом.
